#!/bin/bash

#this script limit cache size  by deleting smallest files in batches of smallest 50

#this is the cache dir
dir="${HOME}/.cache"

#cache limit in kb
cache_limit=500000

#cd into the dir
cd "${dir}" || exit

#evaluate cache size

cache_size_var="$(du -s ${dir} | cut -f 1)"

#convert cache size to decimal from string
int_cache_size=$((10#${cache_size_var}))




#as long as cache size is greater than the limit
while [ ${int_cache_size} -ge ${cache_limit} ];do 

        #list files and sort them by size and delete smallest 50
        files=($(find . -type f -exec du -a {} + | sort -n | head -n 50 ))


        #rm smallest 50 files
        for file in "${files[@]}";do 
	    	rm -f "$file"
        done

        #revaluate cache size
        cache_size_var="$(du -s ${dir} | cut -f 1)"
	    
	    #convert cache size to decimal from string
	    int_cache_size=$((10#${cache_size_var}))
done
