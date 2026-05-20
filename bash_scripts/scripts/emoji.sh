#!/bin/sh

#A rofi script for selecting emojis

#if [[ -z "$@" ]];then
#    cut -d ';' -f1 $HOME/bin/bash_scripts/emoji_list 
#else
#    chosen=$(echo "$@" | sed "s/ .*//" |tr -d '\n')
#    slee 0.2s
#    xdotool type "$chosen" ||  (echo "$chosen" |tr -d '\n' | xclip -selection clipboard && (notify-send "'$@' copied to clipboard.") & )
#else
#   echo "$@" | sed "s/ .*//" |tr -d '\n' | xclip -selection clipboard
#   #echo "$@" | cut -d ' ' -f1 | xclip -selection clipboard
#   notify-send "'$@' copied to clipboard." &  
#   killall rofi  #for some reason rofi was not exiting after this step so to fix it I included this line.
#fi


# emojis file.
EMOJI_FILE="$HOME/bin/bash_scripts/emoji_list"
UNICODE_LIST="$HOME/bin/bash_scripts/unicode.txt"


if [[ -z "$@" ]];then
    cat ${EMOJI_FILE} ${UNICODE_LIST}
    exit 0
elif [[ -n "$1" ]];then
    chosen=$(echo "$@" )
    line=($chosen)
    killall rofi
    #sleep 0.1  # Delay pasting so the text-entry can come active
    xdotool type --clearmodifiers "${line[0]}"
    echo "${line[0]}" | xclip -selection clipboard
    #notify-send "'${line[0]}' copied to clipboard." &
fi
