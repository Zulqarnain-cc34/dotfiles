#!/usr/bin/env bash
# Newsboat bookmark plugin (bookmark-cmd in newsboat/config, default key Ctrl+B).
# Newsboat calls this with 4 positional args -- confirmed against the interface
# shipped in /usr/share/doc/newsboat/examples/example-bookmark-plugin.sh:
url="$1"
title="$2"
description="$3"
feed_title="$4"

bookmarks="$HOME/.newsboat/bookmarks.txt"
printf '%s\t%s\t%s\t%s\t%s\n' "$(date '+%Y-%m-%d %H:%M')" "$url" "$title" "$description" "$feed_title" >> "$bookmarks"

(
    choice=$(dunstify -w -t 15000 -A "default,Open link" --icon=bookmark-new \
        "🔖 Bookmarked" "${title:-$url}" 2>/dev/null)
    [ "$choice" = "default" ] && xdg-open "$url" 2>/dev/null
) &
disown
echo "Bookmarked: ${title:-$url}"
