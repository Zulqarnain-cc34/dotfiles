#!/bin/bash

#script for integration b/w rofi and baloo file indexing
#It is impelemented greping/searching the output selected using rofi in /tmp/search.txt 
#This approach can probably fail if multiple files with similar name are there but is generally faster as compared to associative array approach


#Taking input from rofi and searching using baloo and saving it in text file
echo "" | rofi -dmenu -p "Search: " | xargs -I{} baloosearch {} | sort | uniq > /tmp/search.txt


sed 's/^.*$/"&"/g' /tmp/search.txt | xargs -I{} basename {} |sort | rofi -dmenu -p "Results: " |xargs -I{} grep '{}' /tmp/search.txt | xargs -I{} xdg-open {}

rm /tmp/search.txt
