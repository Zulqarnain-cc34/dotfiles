#!/bin/bash

gm convert -size 810x1080 ${@:3} -resize 810x1080 -extent 810x1080 -background white -compose Copy -gravity center -quality $1 /tmp/$2
rclone sync /tmp/$2 Nust_Onedrive:/

