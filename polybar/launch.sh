#!/usr/bin/env bash
# Start or restart polybar bar "main".

DIR="${XDG_CONFIG_HOME:-$HOME/.config}/polybar"

killall -q polybar 2>/dev/null || true
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.2; done

polybar -q main -c "$DIR/config.ini" &
