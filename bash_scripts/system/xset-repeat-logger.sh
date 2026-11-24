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
# end up causing a drift -- also gets appended to a per-day rolling log
# (pruned after $RAW_LOG_RETENTION_DAYS), separate from the fix log below.
# If a future occurrence isn't caught by the "add" filter at all
# (apparently what happened on 2026-11-24, a real drift with zero
# matching log entry), this raw log is the only record of what udev
# actually broadcast in that window.
#
# Monitors every subsystem, not just input (`--subsystem-match=input`
# dropped from the invocation below) -- the "systemd-logind re-watching
# input devices" theory is itself unconfirmed, so a future occurrence
# caused by some other subsystem's event would otherwise leave the raw
# log just as empty as the fix log was on 2026-11-24. The fix logic
# below still only reacts to an input-subsystem add, since that's the
# one behavior actually confirmed to work; the broader net is purely
# for the raw log and diagnostic snapshot's sake.
#
# A matched line only ever means "this coincided with the drift check" --
# not proven causation, since the real trigger could be a slightly
# earlier or later event (possibly on another subsystem entirely, or
# part of the same burst). The short grace pause before snapshotting, and
# pulling the surrounding raw-log window rather than just the one matched
# line, are both there so the diagnostic snapshot gives real context to
# reason from instead of asserting a single answer that might be wrong.
RATE_DELAY=300
RATE_REPEAT=50
RATE="$RATE_DELAY $RATE_REPEAT"   # must match `xset r rate 300 50` in bspwm/bspwmrc
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
log="$CACHE_DIR/xset-repeat-rate.log"
raw_log_dir="$CACHE_DIR/xset-repeat-raw-udev"
diag_dir="$CACHE_DIR/xset-repeat-diag"
mkdir -p "$raw_log_dir" "$diag_dir"
RAW_LOG_RETENTION_DAYS=14   # per-day files pruned by age, not a volume cap -- predictable
                            # retention regardless of how chatty udev is some weeks
DIAG_CONTEXT_LINES=50       # recent raw-log lines (all subsystems) included in each snapshot
GRACE_SECONDS=0.5           # pause before snapshotting, so a burst of near-simultaneous
                            # events lands in the same diagnostic snapshot, not just the first

prune_raw_logs() {
    find "$raw_log_dir" -maxdepth 1 -name '*.log' -mtime "+$RAW_LOG_RETENTION_DAYS" -delete 2>/dev/null
}

last_pruned_date=""

stdbuf -oL udevadm monitor --udev 2>/dev/null |
while IFS= read -r raw_line; do
    today=$(date '+%Y-%m-%d')
    if [[ "$today" != "$last_pruned_date" ]]; then
        prune_raw_logs
        last_pruned_date="$today"
    fi
    today_raw_log="$raw_log_dir/$today.log"
    echo "$(date '+%Y-%m-%d %H:%M:%S.%3N') $raw_line" >> "$today_raw_log"

    read -r tag _ action _ <<< "$raw_line"
    [[ "$tag" == "UDEV" && "$action" == "add" && "$raw_line" == *"(input)" ]] || continue

    current=$(xset q 2>/dev/null | awk '/auto repeat delay:/ { print $4, $7 }')
    [[ -n "$current" && "$current" != "$RATE" ]] || continue

    sleep "$GRACE_SECONDS"

    ts=$(date '+%Y-%m-%d_%H-%M-%S')
    diag_file="$diag_dir/$ts.log"
    {
        echo "=== drift detected at $(date '+%Y-%m-%d %H:%M:%S') ==="
        echo "was: [$current]  restoring to: [$RATE]"
        echo
        echo "--- matched udev line (coincided with the drift check -- not necessarily the real cause, see context below) ---"
        echo "$raw_line"
        echo
        echo "--- last $DIAG_CONTEXT_LINES raw udev events (all subsystems), including the grace window after detection ---"
        tail -n "$DIAG_CONTEXT_LINES" "$today_raw_log" 2>/dev/null
        echo
        echo "--- journalctl, last 60s ---"
        journalctl --since "60 seconds ago" --no-pager 2>/dev/null
        echo
        echo "--- pacman.log, last 20 lines ---"
        tail -20 /var/log/pacman.log 2>/dev/null
    } > "$diag_file"

    xset r rate "$RATE_DELAY" "$RATE_REPEAT"
    uptime_str=$(awk '{printf "%dh%dm", $1/3600, ($1%3600)/60}' /proc/uptime)
    echo "$(date '+%Y-%m-%d %H:%M:%S') changed: was [$current] -- restored to [$RATE] (session uptime: $uptime_str) -- diag: $diag_file" >> "$log"
done
