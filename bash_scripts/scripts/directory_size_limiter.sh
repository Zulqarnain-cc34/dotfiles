#!/bin/bash

#this script limit director size by deleting smallest files in batches of 50 each

if [ $# -ne 2 ]; then
	printf "Only two arguments are excepted.Please reenter command $0 <directory> <size limit in kb> \n"
fi

#this is the dir
dir="$1"

#cache limit
size_limit="$((10#$2))"

#cd into the dir
cd "${dir}" || exit

#evaluate directory size
dir_size="$(du -s ${dir} | cut -f 1)"
#change size to integer from string
int_dir_size=$((10#${dir_size}))

#as long as cache size is greater than the limit
while [ ${int_dir_size} -ge ${size_limit} ];do 

        #list files and sort them by size and delete smallest 50
        files=($(find . -type f -exec du -a {} + | sort -n | head -n 50 ))


        #rm smallest 50 files
        for file in "${files[@]}";do 
    		rm -f "$file" 
	    done

        #revaluate dir size
        dir_size="$(du -s ${dir} | cut -f 1)"
	    int_dir_size=$((10#${dir_size}))
done
