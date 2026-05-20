#!/bin/bash

cd /home/precision/Images/Assignments/ || exit

if [ $# -eq 0 ]; then
    convert -rotate 90 -size 810x1080 *.jpg -resize 810x1080 -extent 810x1080 -background white -compose Copy -gravity center -quality 50 Muhammad_Zulqarnain_BSAI_200638.pdf
    rclone sync ./Muhammad_Zulqarnain_BSAI_200638.pdf assignmentRepo:/UploadFolder/ --progress
else
    convert -rotate 90 -size 810x1080 *.jpg -resize 810x1080 -extent 810x1080 -background white -compose Copy -gravity center -quality 50 $1
    rclone sync ./"$1" assignmentRepo:/UploadFolder/ --progress
fi
