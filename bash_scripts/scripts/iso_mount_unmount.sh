#!/bin/bash

#This script mounts and unmounts iso files

#Check if only one argument is supplied or not
if [[ $# -ne 1 ]];then
    printf 'Incorrect syntax please re run the command by providing 1 argument. Syntax: %s <iso file >\n' "$0"
    exit 2
fi

# Check if the input is iso file format
if [[ $(file -b --mime-type "$1" | grep -q iso;echo $?) -ne 0 ]] ;then
    printf "Only iso files are allowed.\n"
    exit 2
fi

# Check if the directory exists then umount and rmdir otherwise it will make the directory with the same name as that of iso file and mount iso on that directory.
if [[ -d "${1%.iso}" ]];then
    fusermount -u "${1%.iso}"
    rmdir "${1%.iso}"
    exit 1
else
    mkdir -p "${1%.iso}"
    fuseiso "$1" "${1%.iso}"
    exit 1
fi  
exit 0
