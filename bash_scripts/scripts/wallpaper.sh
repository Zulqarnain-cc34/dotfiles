#!/usr/bin/env bash

if [[ -d "$1" ]];then
    dir="$1"
elif [[ -f "$1" ]];then
    dir=${1%/*}
fi
image="$(nohup sxiv -t -r -q -o "$dir"/*)"

[[ -z $image ]] && exit

cp "$image" ~/.config/wall.png
xwallpaper --stretch "$image"
