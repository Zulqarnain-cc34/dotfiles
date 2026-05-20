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
exec 204>$pidfile
flock -n 204 || another_instance
pid=$$
echo $pid 1>&204

path="$HOME/.local/share/email/gmail/INBOX/new"
cd $path || exit

# syncs email to local folder
mbsync -c ~/.config/isync/mbsyncrc -a >/dev/null 2>&1

## checks for new emails on first run
# path of file to store output of last run ls command
lsout="$HOME/.local/share/email/lsout.txt" 
# if lsout file doesn't exist create it or otherwise change its timestamp
touch $lsout
# store output of last ls in the file lsout on exit
trap 'ls > $lsout' EXIT
# path of file to store newly created files
TMPFILE=$(mktemp)
# calculating differnce in between current ls and last stored ls
combine <(ls) not $lsout > $TMPFILE

# for all new emails send notification
while IFS= read -r line
do
  notify-send -t 15000 "$(sed -ne 's/^From/Email &/p' $line)" "$(grep -e '^Subject' $line)"
done < "$TMPFILE"

## watches for any new file being created if script is already running
inotifywait -m $path -e create -e moved_to |
    while read dir action file; do
        export DISPLAY=:0
        notify-send -t 15000 "$(sed -ne 's/^From/Email &/p' $file)" "$(grep -e '^Subject' $file)"
        # do something with the file
    done
