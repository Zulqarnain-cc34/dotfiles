#!/bin/bash
# Restores X's keyboard auto-repeat rate the instant it drifts, and logs
# every real occurrence with a timestamp plus a diagnostic snapshot of
# what else was happening around it.
#
# Root cause (confirmed by correlating a logged occurrence's timestamp
# against both /var/log/Xorg.0.log and `journalctl`): a `systemctl
# daemon-reload` -- commonly triggered by a pacman post-install hook --
# cascades into systemd-logind re-watching every input device, which
# Xorg/libinput sees as the keyboard being removed and re-added, resetting
# the rate to X11's own built-in default (660 25). Not suspend/resume, and
# not something to prevent at the source -- daemon-reload is normal,
# necessary system behavior.
#
# That diagnosis came from one occurrence and doesn't fully hold up: a
# later recurrence (2026-11-24) produced no log entry at all -- the "add"
# event this script reacts to apparently never matched -- and afterward,
# manually replaying every individual candidate (a bare udev add trigger,
# system and user daemon-reload, udevadm control --reload) separately
# failed to reproduce the drift at all. The real trigger is likely some
# combination/ordering of these during an actual package upgrade, not any
# one of them in isolation -- which the rolling raw log below exists to
# actually pin down next time, instead of guessing again after the fact.
#
# Event-driven on purpose, not polled: the exact trigger is a udev "add"
# event on the input subsystem, so this subscribes to that directly via
# `udevadm monitor` instead of checking on a timer. Reacts immediately,
# with no polling overhead and no window where the rate is wrong.
# Delay/rate kept as separate values, not one "300 50" string -- passing
# that to `xset r rate` unquoted relies on word-splitting, which bash does
# but isn't something to depend on here.
#
# `stdbuf -oL` on udevadm: confirmed by reproduction that without it,
# udevadm fully block-buffers stdout once it isn't a tty, so a single
# sparse event can sit stuck in the buffer indefinitely (it never fills)
# and never reach the loop below -- a real occurrence happened and went
# completely unlogged because of this.
#
# Every raw UDEV line -- not just "add" events, and not just ones that
# end up causing a drift -- also gets appended to a capped rolling log,
# separate from the fix log below. If a future occurrence isn't caught by
# the "add" filter at all (apparently what happened on 2026-11-24, a real
# drift with zero matching log entry), this raw log is the only record of
# what udev actually broadcast in that window, so the real trigger can
# finally be identified instead of replayed guess by guess.
RATE_DELAY=300
RATE_REPEAT=50
RATE="$RATE_DELAY $RATE_REPEAT"   # must match `xset r rate 300 50` in bspwm/bspwmrc
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
log="$CACHE_DIR/xset-repeat-rate.log"
raw_log="$CACHE_DIR/xset-repeat-raw-udev.log"
diag_dir="$CACHE_DIR/xset-repeat-diag"
mkdir -p "$diag_dir"
RAW_LOG_MAX_LINES=2000

stdbuf -oL udevadm monitor --udev --subsystem-match=input 2>/dev/null |
while IFS= read -r raw_line; do
    echo "$(date '+%Y-%m-%d %H:%M:%S.%3N') $raw_line" >> "$raw_log"
    if (( $(wc -l < "$raw_log") > RAW_LOG_MAX_LINES )); then
        tail -n "$RAW_LOG_MAX_LINES" "$raw_log" > "$raw_log.tmp" && mv "$raw_log.tmp" "$raw_log"
    fi

    read -r tag _ action _ <<< "$raw_line"
    [[ "$tag" == "UDEV" && "$action" == "add" ]] || continue

    current=$(xset q 2>/dev/null | awk '/auto repeat delay:/ { print $4, $7 }')
    [[ -n "$current" && "$current" != "$RATE" ]] || continue

    ts=$(date '+%Y-%m-%d_%H-%M-%S')
    diag_file="$diag_dir/$ts.log"
    {
        echo "=== drift detected at $(date '+%Y-%m-%d %H:%M:%S') ==="
        echo "was: [$current]  restoring to: [$RATE]"
        echo
        echo "--- triggering udev line ---"
        echo "$raw_line"
        echo
        echo "--- journalctl, last 15s ---"
        journalctl --since "15 seconds ago" --no-pager 2>/dev/null
        echo
        echo "--- pacman.log, last 20 lines ---"
        tail -20 /var/log/pacman.log 2>/dev/null
    } > "$diag_file"

    xset r rate "$RATE_DELAY" "$RATE_REPEAT"
    uptime_str=$(awk '{printf "%dh%dm", $1/3600, ($1%3600)/60}' /proc/uptime)
    echo "$(date '+%Y-%m-%d %H:%M:%S') changed: was [$current] -- restored to [$RATE] (session uptime: $uptime_str) -- diag: $diag_file" >> "$log"
done
