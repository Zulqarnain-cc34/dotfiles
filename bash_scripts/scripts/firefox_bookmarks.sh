#!/bin/bash

db_location="$HOME/bin/bookmarks/bookmarks.sqlite"
if [ -z $@ ];then
    sqlite3 $db_location "select title from bookmarks"
else
    title="$@"
    url="$(sqlite3 $db_location "select url from bookmarks where bookmarks.title='$title'")"
    qutebrowser $url
fi

