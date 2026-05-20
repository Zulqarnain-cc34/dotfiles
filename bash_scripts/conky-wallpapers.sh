#!/usr/bin/env bash

CONKY_THEMES=("$PWD/.config/conky/conky1/conkyrc1" "$PWD/.config/conky/conky2/conkyrc2")
CURRENT_THEME=0

if [[ $1 ]]; then
    WALLPAPER_DIR=$1
else
    WALLPAPER_DIR="/home/precision/Images/backgrounds/"
fi

cd $WALLPAPER_DIR || exit
COUNT=0
TOGGLE=0

for path in $(ls -a); do
    if [[ $((COUNT % 2)) -eq 0 ]]; then
        echo "Changes Conky System Moniter " "$path"
        change-conky 1
    fi
    echo "$path"
    COUNT=$((COUNT + 1))
done

function change-conky() {
    CURRENT_THEME=$1
    # killall conky processes
    killall -q conky
    # wait until all conky instances have been shutdown
    while pgrep -u $UID -x conky >/dev/null; do sleep 1; done
    # Conky Exited with Status 1
    echo "Conky Exited Successfully"
    [[ -v $CURRENT_THEME ]] && nohup conky -q -c ${CONKY_THEMES[$1]}
}
