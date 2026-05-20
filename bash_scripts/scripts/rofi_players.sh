#!/usr/bin/env bash

if [[ -z "$@" ]];then
    echo "$(playerctl -l)"
else
    playerctl -p "$@" play-pause
    killall rofi
fi

