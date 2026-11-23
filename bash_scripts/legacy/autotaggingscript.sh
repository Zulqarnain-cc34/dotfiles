#!/usr/bin/bash

#This script tags music files by extracting date and album name from foldername. Typical name is as [2007.02.01] Album Name
# This script uses mid3v2 to tag

NUM_REQUIRED_ARGS=1
if [[ $# != $NUM_REQUIRED_ARGS ]]; then
	echo "Incorrect number of arguments. Re-type syntax with $0 <dir> "
	exit 1
fi


#change directory(in case of failed exit code and echo failed 
cd "$1" || exit


#for every folder in every directory in current directory
for folder in */; do
#change directory to that folder
    cd "$folder" || echo "Failed to edit tags in ${folder}"

    #album name = basename of folder and cut from field 2 to n using dilimiter of " "
    album_name="$(basename  "$folder" | cut -d ' ' -f2-)"

    #release date = {same as above} and grep for regex to extract date of type yyyy.mm.dd
    release_date="$(basename "$folder" | grep -Eo '[[:digit:]]{4}.[[:digit:]]{2}.[[:digit:]]{2}')"

    #for loop for mp3 file in current directory and change tags
    for file in *.mp3; do mid3v2 -A "$album_name" --date="$release_date" "${file}"; done

    #this solution is limited as it can only tag in current directory and not
    #recursively. To tag recursively use following #find every mp3 in current
    #directory and exec following command(in this case tag music file or run
    #mid3v2 command) #find . -name "*.mp3" -type f -print0 | xargs -0 mid3v2 -A
    #"${album_name}" --date="${release_date}"

    #change directiory out of current one so the first for loop can proceed
    #otherwise it will stay in this diectory.

    cd ..

    done
exit 0
