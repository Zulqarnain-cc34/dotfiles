#!/bin/bash
# Logs every change to X's keyboard auto-repeat delay/rate with a timestamp,
# to catch a "random" mid-session slowdown in the act instead of guessing.
# If a logged change lands on "660 25" specifically, that's X11's own
# built-in default -- strong evidence of a reset (device reinit, some tool
# re-applying defaults) rather than something setting an arbitrary new rate.
#
# Meant to run unattended for days until the bug reoccurs, so two things
# matter: never log a false change (a transient `xset q` failure must not
# look like a real rate change), and carry enough context in each real
# entry (how long the session had been up) that the evidence is still
# useful without needing to remember what you were doing at the time.
log="${XDG_CACHE_HOME:-$HOME/.cache}/xset-repeat-rate.log"
last=""
while true; do
    current=$(xset q 2>/dev/null | awk '/auto repeat delay:/ { print $4, $7 }')
    if [[ -n "$current" ]]; then
        if [[ "$current" != "$last" && -n "$last" ]]; then
            uptime_str=$(awk '{printf "%dh%dm", $1/3600, ($1%3600)/60}' /proc/uptime)
            echo "$(date '+%Y-%m-%d %H:%M:%S') changed: was [$last] now [$current] (session uptime: $uptime_str)" >> "$log"
        fi
        last="$current"
    fi
    # current empty -> xset q failed this poll (transient X hiccup); skip
    # the comparison entirely rather than treat it as a real change, and
    # don't overwrite $last so the next good poll compares against the
    # real last-known value.
    sleep 3
done
