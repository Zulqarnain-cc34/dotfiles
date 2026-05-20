#!/bin/dash

search_term="$1"

dir_name=$(find . -maxdepth 1 -type d -regex "^\./${search_term}.*" | head -n 1)

cd $dir_name

exa -l
