#!/bin/bash
# stop on errors
set -e
another_instance()
{
  echo "There is another instance running, exiting"
  exit 1
} 

scriptname="$(basename $0).lock"
pidfile="/tmp/${scriptname}"
 
# lock it
exec 200>$pidfile
flock -n 200 || another_instance
pid=$$
echo $pid 1>&200
 
dir="${1:-${HOME}/Pictures/Wallpapers/Wallpapers/}"
time=${2:-1000}

#while [ TRUE ];do 
#    find "${dir}" -type f |xargs -I{} printf "\047{}\047\n" | shuf -n 1 | xargs -I{} sh -c 'feh --bg-scale "$1" && cp "$1" ${HOME}/.config/wall.png' sh {} 
#
#    #cp $filename $HOME/.config/wall.png
#    
#    sleep $time
#done
while [ TRUE ];do

    if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
        gsettings set org.gnome.desktop.background picture-uri "$(/bin/ls -d $dir/* | shuf -n 1)"
    else
        xwallpaper --stretch "$(/bin/ls -d $dir/* | shuf -n 1)"
    fi

    sleep $time
done
