#!/bin/bash

cd /tmp || exit

url="$(xclip -out -selection primary)"

yt-dlp --write-sub --skip-download "$url"

mv /tmp/*?.srt /tmp/sub.srt


mpv --sub-file="sub.srt" "$url"

rm -f *.srt

