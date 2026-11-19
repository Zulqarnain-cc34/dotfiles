#!/bin/bash
# Fast-polling brightness status for polybar's custom/script module
# (tail = true). xbacklight changes have no event bus to subscribe to like
# pulseaudio does, so this polls quickly and only prints on an actual change
# -- close to instant without adding a new inotify-tools dependency.

YELLOW=E5C07B
RAMP=("" "" "" "" "")

last=-1
while true; do
    bright=$(xbacklight -get | cut -d. -f1)
    if [[ "$bright" != "$last" ]]; then
        idx=$(( bright * 5 / 101 ))
        (( idx > 4 )) && idx=4
        printf '%%{F#%s}%s%%{F-} %s%%%%\n' "$YELLOW" "${RAMP[$idx]}" "$bright"
        last=$bright
    fi
    sleep 0.15
done
