#!/bin/bash
# Logs every change to X's keyboard auto-repeat delay/rate with a timestamp,
# to catch a "random" mid-session slowdown in the act instead of guessing.
# If a logged change lands on "660 25" specifically, that's X11's own
# built-in default -- strong evidence of a reset (device reinit, some tool
# re-applying defaults) rather than something setting an arbitrary new rate.
log="${XDG_CACHE_HOME:-$HOME/.cache}/xset-repeat-rate.log"
last=""
while true; do
    current=$(xset q | awk '/auto repeat delay:/ { print $4, $7 }')
    if [[ "$current" != "$last" && -n "$last" ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') changed: was [$last] now [$current]" >> "$log"
    fi
    last="$current"
    sleep 3
done
