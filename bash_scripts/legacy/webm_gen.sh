#!/bin/bash

file="$1"
bitrate="$2"
scale="$3"
#webm 1st pass
ffmpeg -i "$file" -codec:v libvpx -quality good -cpu-used 0 -b:v 1k -qmin 26 -qmax 42 -maxrate 3000k -bufsize 1000k -threads 2 -y -an -pass 1 -f webm /dev/null
##webm 3st pass
ffmpeg -i "$file" -codec:v libvpx -quality good -cpu-used 0 -b:v 1k -qmin 26 -qmax 42 -maxrate 3000k -bufsize 1000k -threads 2 -an -pass 2 -f webm "${file%.*}.webm"
#ffmpeg -i "$file" -c:v libvpx -crf 4 -b:v ${bitrate:-225}k -vf scale=${scale:-640}:-1 -an "${file%.*}.webm"
#-maxrate 1000k
