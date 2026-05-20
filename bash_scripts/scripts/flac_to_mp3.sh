#!/usr/bin/bash

NUM_REQUIRED_ARGS=1
if [[ "$#" != "$NUM_REQUIRED_ARGS" ]]; then
	echo "Incorrect number of arguments. Re-type syntax with $0 <dir> "
	exit 1
fi


#change directory(in case of failed exit code and echo failed 
cd "$1" || exit


#for every folder in every directory in current directory
for folder in */; do
		#change directory to that folder
        cd "$folder" || echo "Failed to edit tags in ${folder}"
		
		#for every flac file convert it to mp3 using ffmpeg
		for i in *.flac; do ffmpeg -i "$i" -acodec libmp3lame -vsync 2 -b:a 192k "$(basename "${i/.flac}")".mp3;done 
        #above solution is limited as it can only act in current directory and not recursively. To perform a action recursively use find command followed by xargs

        #Following implementaion results in filname as filename.flac.mp3 as compared to filename.mp3
#       find . -name "*.flac" -type f -print0 |xargs -0 -I{} ffmpeg -i {} -acodec libmp3lame -vsync 2 -b:a 192k {}.mp3

		#change directiory out of current one so the first for loop can proceed otherwise it will stay in this diectory.
		cd ..

done
exit 0
