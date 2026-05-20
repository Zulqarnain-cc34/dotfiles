#!/bin/bash

#script for integration b/w rofi and baloo file indexing
#It is impelemented using associative arrays


#Taking input from rofi and searching using baloo and saving it in text file
echo "" | rofi -dmenu -p "Search: " | xargs -I{} baloosearch {} | sed 's/^.*$/"&"/g' |sort |uniq > /tmp/search.txt

# converting above generated text file to an associative array
awk -F'/' 'BEGIN{print "#!/bin/bash\ndeclare -A file_name=("} {print "[\""$NF"]="$0} END {print ")"}' /tmp/search.txt > /tmp/search.sh

#changing permission and sourceing above file
chmod +x /tmp/search.sh

source /tmp/search.sh

#Selecting file in rofi and opening it using xdg-open
key=$(xargs -a /tmp/search.txt -I{} basename {} | sort | rofi -dmenu -p "Results: "| xargs echo )

xdg-open "${file_name[$key]}"

#Removing above generated files
rm /tmp/search.txt /tmp/search.sh








