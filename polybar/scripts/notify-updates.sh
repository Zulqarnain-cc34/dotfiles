#! /bin/sh
yay -Qum | awk '{print $1;}' | sed 's/\x1b\[[0-9;]*m//g' | xargs -0 notify-send -t 10000
