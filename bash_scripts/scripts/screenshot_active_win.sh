#!/bin/sh
set -e

DATE=$(date +"%Y-%m-%d_%H:%M:%S.%N")
ACTIVE_WIN_CMD=$(xdotool getactivewindow)
maim -i $ACTIVE_WIN_CMD "$HOME/Pictures/Spectacle/Screenshot-$DATE.png"
