#!/bin/sh
# Stub: replace with wallpaper setter (bspwm autostart)
command -v feh >/dev/null 2>&1 && feh --bg-fill "$HOME/Pictures/wallpapers" 2>/dev/null || true
exit 0
