#!/bin/bash
# Brightness OSD: adjusts screen brightness via xbacklight and shows a dunst
# progress-bar notification for it, replacing itself instead of stacking.

STEP=5

case "$1" in
    up)   xbacklight -inc "$STEP" ;;
    down) xbacklight -dec "$STEP" ;;
    *) echo "usage: $0 {up|down}" >&2; exit 1 ;;
esac

bright=$(xbacklight -get | cut -d. -f1)

dunstify -a "brightness" -u low -i display-brightness \
    --stack-tag brightness -h int:value:"$bright" "Brightness: ${bright}%"
