#!/bin/sh

URL="https://www.reddit.com/message/unread/?feed=fff5f70a97d390ae830d3fccea754f77d685f270&user=precision16918"

USERAGENT="precision16918"

notifications=$(curl -sf --user-agent "$USERAGENT" "$URL" | jq '.["data"]["children"] | length')

if [ -n "$notifications" ] && [ "$notifications" -gt 0 ]; then
    echo "#1 $notifications"
else
    echo "#2"
fi
