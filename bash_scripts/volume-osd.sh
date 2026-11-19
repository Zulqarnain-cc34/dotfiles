#!/bin/bash
# Volume OSD: adjusts the default sink and shows a dunst progress-bar
# notification for it, replacing itself instead of stacking.

STEP=5
SINK=@DEFAULT_SINK@

case "$1" in
    up)   pactl set-sink-mute "$SINK" false; pactl set-sink-volume "$SINK" "+${STEP}%" ;;
    down) pactl set-sink-mute "$SINK" false; pactl set-sink-volume "$SINK" "-${STEP}%" ;;
    mute) pactl set-sink-mute "$SINK" toggle ;;
    *) echo "usage: $0 {up|down|mute}" >&2; exit 1 ;;
esac

vol=$(pactl get-sink-volume "$SINK" | awk '/Volume:/ { print $5 }' | tr -d '%')
muted=$(pactl get-sink-mute "$SINK" | awk '{ print $2 }')

if [[ "$muted" == "yes" ]]; then
    dunstify -a "volume" -u low -i audio-volume-muted \
        --stack-tag volume "Volume muted"
else
    icon=audio-volume-high
    (( vol < 30 )) && icon=audio-volume-low
    (( vol == 0 )) && icon=audio-volume-muted
    dunstify -a "volume" -u low -i "$icon" \
        --stack-tag volume -h int:value:"$vol" "Volume: ${vol}%"
fi
