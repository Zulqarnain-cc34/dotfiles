##!/bin/sh

# make sure to kill script and zscroll if mpv exits
while :
     do
       sleep 1
     if ! pidof mpv > /dev/null
        then
            killall zscroll
            exit
     fi
done &

zscroll --length 25 --delay 0.3 \
	--match-command "$HOME/.config/polybar/scripts/polybar-mpv/mpv.sh --status" \
	--match-text "true" "--after-text ' ' --scroll false" \
	--match-text "false" "--after-text ' ' --scroll true" \
	--update-check true "$HOME/.config/polybar/scripts/polybar-mpv/mpv.sh --title" &
wait
