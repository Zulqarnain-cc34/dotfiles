#!/bin/bash
set -e
another_instance()
{
  echo "There is another instance running, exiting"
  exit 1
} 

scriptname="$(basename $0).lock"
pidfile="/tmp/${scriptname}"
 
# lock it
exec 203>$pidfile
flock -n 203 || another_instance
pid=$$
echo $pid 1>&203

while true
do
    if [ -n "$(calcurse -n)" ]
    then
        total_time=$(calcurse -n | sed -nE 's/.*([0-9]{2}:[0-9]{2}).*/\1/p')

        hour_remaining=$(echo $total_time | xargs -I{} date -d {} "+%-H")
        min_remining=$(echo $total_time | xargs -I{} date -d {} "+%-M")
        time_remaining=$(( hour_remaining*60 + min_remining ))
        # echo $time_remaining

        if [ $time_remaining -le 5 ]
        then
            notify-send "less than 5 min left for appointment" "$(calcurse -n)" -u critical
            sleep "$(( $time_remaining + 1 ))"m
        elif [ $time_remaining -le 15 ]
        then
            notify-send "less than 15 min left for appointment" "$(calcurse -n)" -t 15000
            sleep "$(( $time_remaining - 5 + 1 ))"m
        elif [ $time_remaining -le 30 ]
        then
            notify-send "less than 30 min left for appointment" "$(calcurse -n)"
            sleep "$(( $time_remaining - 15 + 1 ))"m
        elif [ $time_remaining -le 60 ]
        then
            notify-send "less than 60 min left for appointment" "$(calcurse -n)"
            sleep "$(( $time_remaining - 30 + 1 ))"m
        fi
    else
        sleep 2m
    fi
done
