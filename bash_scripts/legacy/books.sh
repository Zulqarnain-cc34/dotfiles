#!/bin/bash

#this scripts uses rofi to frequently access certain books

cd ~/Documents/frequent || exit

if [[ -z "$@" ]];then
    /bin/ls
else
    zathura "$@" &
    killall rofi
fi
