#!/usr/bin/env bash

if [[ -z "$@" ]];then
    printf "$(cat /sys/class/power_supply/BAT0/capacity)%% \nIncrease Brightness\nDecrease Brightness\nSet Brightness Maximum"
else
    case "$@" in
        "Increase Brightness")
            xbacklight +10;;
        "Decrease Brightness")
            xbacklight -10;;
        "Set Brightness Maximum")
            xbacklight =100;;
        *)
            printf "Invalid Input\n"
    esac
fi
