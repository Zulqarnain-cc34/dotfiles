#!/bin/bash

input=$(xclip -out -selection clipborad)

$TERMINAL -e youtube-dl -o '/home/precision/Videos/videos/%(title)s' ${input}
