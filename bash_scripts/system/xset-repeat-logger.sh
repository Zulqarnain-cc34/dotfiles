#!/bin/bash
# Restores X's keyboard auto-repeat rate the instant it drifts, and logs
# every real occurrence with a timestamp.
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
# Event-driven on purpose, not polled: the exact trigger is a udev "add"
# event on the input subsystem, so this subscribes to that directly via
# `udevadm monitor` instead of checking on a timer. Reacts immediately,
# with no polling overhead and no window where the rate is wrong.
# Delay/rate kept as separate values, not one "300 50" string -- passing
# that to `xset r rate` unquoted relies on word-splitting, which bash does
# but isn't something to depend on here.
#
# `stdbuf -oL` on both pipeline stages: confirmed by reproduction that
# without it, udevadm/awk fully block-buffer stdout once it isn't a tty,
# so a single sparse "add" match can sit stuck in the buffer indefinitely
# (it never fills) and never reach the `while read` loop below -- a real
# occurrence happened and went completely unlogged because of this.
RATE_DELAY=300
RATE_REPEAT=50
RATE="$RATE_DELAY $RATE_REPEAT"   # must match `xset r rate 300 50` in bspwm/bspwmrc
log="${XDG_CACHE_HOME:-$HOME/.cache}/xset-repeat-rate.log"

stdbuf -oL udevadm monitor --udev --subsystem-match=input 2>/dev/null |
stdbuf -oL awk '$1 == "UDEV" && $3 == "add"' |
while read -r _; do
    current=$(xset q 2>/dev/null | awk '/auto repeat delay:/ { print $4, $7 }')
    [[ -n "$current" && "$current" != "$RATE" ]] || continue
    xset r rate "$RATE_DELAY" "$RATE_REPEAT"
    uptime_str=$(awk '{printf "%dh%dm", $1/3600, ($1%3600)/60}' /proc/uptime)
    echo "$(date '+%Y-%m-%d %H:%M:%S') changed: was [$current] -- restored to [$RATE] (session uptime: $uptime_str)" >> "$log"
done
