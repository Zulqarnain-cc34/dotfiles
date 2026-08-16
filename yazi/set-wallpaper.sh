#!/usr/bin/env bash
# Set the hovered image in yazi as the X11 wallpaper. Bound to `bg` in keymap.toml.
#
# Mirrors the lf `setwallpaper` convention: persist a copy to ~/.config/wall.png
# (which autostart.sh restores on login) and apply it immediately.
#
# Usage: set-wallpaper.sh <image-file>

set -euo pipefail

notify() { command -v notify-send >/dev/null 2>&1 && notify-send "Wallpaper" "$1"; }

file="${1:-}"
if [[ ! -f "$file" ]]; then
    notify "Not a file: ${file:-<none>}"
    exit 1
fi

# Only accept images — avoids setting a text/binary file as the wallpaper.
mime="$(file -Lb --mime-type -- "$file" 2>/dev/null || true)"
if [[ "$mime" != image/* ]]; then
    notify "Not an image: ${file##*/} (${mime:-unknown})"
    exit 1
fi

# Persist for restore-on-login (autostart.sh reads ~/.config/wall.png).
cp -f -- "$file" "$HOME/.config/wall.png"

# Apply now — prefer xwallpaper, then feh, then hsetroot (matches random-wallpaper.sh).
if command -v xwallpaper >/dev/null 2>&1; then
    xwallpaper --stretch "$file"
elif command -v feh >/dev/null 2>&1; then
    feh --bg-fill "$file"
elif command -v hsetroot >/dev/null 2>&1; then
    hsetroot -fill "$file"
else
    notify "No X11 wallpaper tool found (xwallpaper/feh/hsetroot)"
    exit 1
fi

notify "Set: ${file##*/}"
