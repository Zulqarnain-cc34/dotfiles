#!/bin/zsh
klipper="qdbus org.kde.klipper /klipper org.kde.klipper.klipper"
get_content="$klipper.getClipboardHistoryMenu"
set_content="$klipper.setClipboardContents"
clear_history="$klipper.clearClipboardHistory"
show_klipper="$klipper.showKlipperPopupMenu"
get_item="$klipper.getClipboardHistoryItem"

#this fn. trims multiline to single line
function list(){
	i=0
	last_item="something"
	while [[ ! -z $last_item ]];do
		eval "$get_item $i" | paste -sd ' ' | cut -c1-80 | read last_item 
		i=$((i+1))
		echo $last_item
	done
}
#Alt+n is just to free Shift+Delete 
selected=$(list | rofi -dmenu -format i -i -p "clipboard" -mesg "Alt+m to open klipper" -kb-delete-entry "Alt+n" -kb-custom-1 "Shift+Delete" -kb-custom-2 "Alt+m" )
ret=$?

case $ret in
	10)
		#delee selected
		#dunno how.. so clear all ;)
		eval $clear_history
		;;
	11)
		#Alt+m
		eval $show_klipper
		;;
	0)
		#update clipboard with selected
		eval $get_item "$selected" | head -c -1 | eval xargs -0 -IREPLACE $set_content REPLACE
		#eval $get_item "$selected" | perl -pe 'chomp if eof' - | eval xargs -0 -IREPLACE $set_content REPLACE
		;;
esac
