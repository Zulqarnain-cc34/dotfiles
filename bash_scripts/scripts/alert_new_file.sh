#!/bin/dash
set -e
path="$HOME/.local/share/email/gmail/INBOX/new"
cd $path || exit
inotifywait -m $path -e create -e moved_to |
    while read dir action file; do
        export DISPLAY=:0
        notify-send "$(sed -ne 's/^From/Email &/p' $file)" "$(grep -e '^Subject' $file)"
        # do something with the file
    done
