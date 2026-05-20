#!/bin/sh
# Author desktop: three outputs (DisplayPort + HDMI).
# Monitor names from: xrandr --query | grep ' connected'

bspc monitor DisplayPort-0 -d 1 2 3 4 5 6 7
bspc monitor DisplayPort-1 -d 8 9
bspc monitor HDMI-A-0 -d 10
