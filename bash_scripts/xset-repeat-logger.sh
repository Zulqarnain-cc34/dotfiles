#!/bin/bash
# Logs every change to X's keyboard auto-repeat delay/rate with a timestamp,
# and actively restores it. Root cause (confirmed by correlating a logged
# occurrence against /var/log/Xorg.0.log's timestamps) is a udev-level
# keyboard device re-enumeration -- "config/udev: removing device ...
# keyboard" immediately followed by "Adding input device ... keyboard" --
# which makes libinput reinitialize the device to X11's own built-in
# default (660 25). This is NOT a suspend/resume event, so the rate can
# drift at any time, unattended -- this loop is what actually catches it
# and fixes it within one poll interval instead of waiting for a manual
# `xset r rate` or the next bspwmrc reload.
#
# Never log/fix on a false change (a transient `xset q` failure must not
# look like a real rate change), and carry enough context in each real
# entry (how long the session had been up) that the evidence is still
# useful without needing to remember what you were doing at the time.
RATE="300 50"   # must match `xset r rate 300 50` in bspwm/bspwmrc
log="${XDG_CACHE_HOME:-$HOME/.cache}/xset-repeat-rate.log"
last=""
while true; do
    current=$(xset q 2>/dev/null | awk '/auto repeat delay:/ { print $4, $7 }')
    if [[ -n "$current" ]]; then
        if [[ "$current" != "$last" && -n "$last" ]]; then
            uptime_str=$(awk '{printf "%dh%dm", $1/3600, ($1%3600)/60}' /proc/uptime)
            if [[ "$current" != "$RATE" ]]; then
                xset r rate $RATE
                echo "$(date '+%Y-%m-%d %H:%M:%S') changed: was [$last] now [$current] -- restored to [$RATE] (session uptime: $uptime_str)" >> "$log"
                current="$RATE"
            else
                echo "$(date '+%Y-%m-%d %H:%M:%S') changed: was [$last] now [$current] (session uptime: $uptime_str)" >> "$log"
            fi
        fi
        last="$current"
    fi
    # current empty -> xset q failed this poll (transient X hiccup); skip
    # the comparison entirely rather than treat it as a real change, and
    # don't overwrite $last so the next good poll compares against the
    # real last-known value.
    sleep 3
done
