#!/bin/bash
# Event-driven volume status for polybar's custom/script module (tail = true).
# Prints one status line immediately, then one new line each time pulseaudio's
# event bus reports a sink/mute change -- mirrors how internal/pulseaudio
# reacted instantly instead of polling.

BLUE=61AFEF
RED=E06C75
ICON_LOW="奄"
ICON_MED="奔"
ICON_HIGH="墳"
ICON_MUTED="婢"

status() {
    local vol muted icon
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume:/ { print $5 }' | tr -d '%')
    muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{ print $2 }')
    if [[ "$muted" == "yes" ]]; then
        printf '%%{F#%s}%s%%{F-} Muted\n' "$RED" "$ICON_MUTED"
    else
        icon=$ICON_HIGH
        (( vol < 60 )) && icon=$ICON_MED
        (( vol < 30 )) && icon=$ICON_LOW
        printf '%%{F#%s}%s%%{F-} %s%%%%\n' "$BLUE" "$icon" "$vol"
    fi
}

status
pactl subscribe 2>/dev/null | grep --line-buffered -E "sink #" | while read -r _; do
    status
done
