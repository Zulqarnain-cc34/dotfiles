#!/bin/bash

input=$(xclip -out -selection clipborad)

$TERMINAL -e yt-dlp -o '$HOME/Videos/videos/%(title)s' ${input}
