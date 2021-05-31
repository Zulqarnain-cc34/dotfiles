#!/bin/sh

if [ "$1" == "--status" ]; then
echo '{ "command": ["get_property", "core-idle"] }' | socat - /tmp/mpv_socket | jq .data

elif [ "$1" == "--title" ]; then
echo '{ "command": ["get_property", "media-title"] }' | socat - /tmp/mpv_socket | jq .data | tr '"' ' ' | sed -e 's/\.[^.]*$//'

elif [ "$1" == "--volume-up" ]; then
tmp_vol=$(echo '{ "command": ["get_property", "volume"] }' | socat - /tmp/mpv_socket | jq .data | cut -d "." -f 1 )
tmp_vol=$((tmp_vol+5))
echo '{ "command": ["set_property", "volume", '$tmp_vol'] }' | socat - /tmp/mpv_socket

elif [ "$1" == "--volume-down" ]; then
tmp_vol=$(echo '{ "command": ["get_property", "volume"] }' | socat - /tmp/mpv_socket | jq .data | cut -d "." -f 1 )
tmp_vol=$((tmp_vol-5))
echo '{ "command": ["set_property", "volume", '$tmp_vol'] }' | socat - /tmp/mpv_socket

fi

