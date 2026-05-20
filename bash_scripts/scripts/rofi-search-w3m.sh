#!/usr/bin/env bash
#

cache_file="/home/wasif/.local/share/surfraw/cache"
cache_dir=${cache_file%/*}
search_engine=duckduckgo

if [[ ! -d "$cache_dir" ]];then
    mkdir -p $cache_dir
fi
if [[ ! -f "$cache_file" ]];then
    touch "$cache_file"
fi


search_query="$(tac $cache_file | rofi -dmenu)"
echo "$search_query" >> ~/.local/share/surfraw/cache
if [[ -n "$search_query" ]]
then
    surfraw -browser=w3m $search_engine $search_query
fi
