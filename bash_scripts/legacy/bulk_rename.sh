#!/bin/dash


default_name="saho.jpg"
case $1 in 
    ""|[A-Za-z0-9][A-Za-z0-9]*.[A-Za-z0-9][A-Za-z0-9]*) 
        name="${1:-${default_name}}"
        ;;
    *)
        echo "Specified Name pattern is wrong.The pattern should consist of \
<alphanumeric>.<alphanumeric> type pattern."
        exit 1;;
esac


i=1
for file in *
do
    if [ ! -d "$file" ]
    then
        mv --backup $file "${name%.*}-$i.${name##*.}"
        i=$((i+1))
    fi
done
