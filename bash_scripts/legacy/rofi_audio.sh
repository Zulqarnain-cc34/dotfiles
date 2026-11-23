#!/usr/bin/env bash

if [[ -z "$@" ]];then
    echo "$(echo "$(amixer get Master)" | grep -o "\[[0-9]\+%\]" | sed "s/[^0-9]*//g;1q")%"
    printf "Increase Volume\nDecrease Volume"
else
    case "$@" in
        "Increase Volume")
            pactl -- set-sink-volume 0 +5% && kill -44 $(pidof dwmblocks);;
        "Decrease Volume")
            pactl -- set-sink-volume 0 -5% && kill -44 $(pidof dwmblocks);;
        *)
            echo "Invalid Input";;
    esac
fi
