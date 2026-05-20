#!/bin/bash

db_location="$HOME/.local/share/places.sqlite"
if [ -z $@ ];then
    rsync .mozilla/firefox/oduj1f5k.default-release/places.sqlite $db_location &> /dev/null
    sqlite3 $db_location "select title from moz_bookmarks where moz_bookmarks.fk is not NULL"
else
    title="$@"
    fk=$(sqlite3 $db_location "select fk from moz_bookmarks where moz_bookmarks.title='$title';")
    url="$(sqlite3 $db_location "select url from moz_places where moz_places.id=$fk;")"
    qutebrowser $url
fi

