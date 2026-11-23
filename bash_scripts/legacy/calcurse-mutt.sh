#!/bin/dash

~/bin/python_scripts/mutt-ics.py "$@" | less -S

dialog --yesno "Do you want to save this in calcurse" 10 30 && calcurse -i "$@"
