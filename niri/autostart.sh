#!/usr/bin/env bash
# Wayland session extras started from niri/config.kdl

set -euo pipefail

mkdir -p "$HOME/Pictures/screenshots"

if command -v swww-daemon >/dev/null 2>&1; then
    swww-daemon
    if command -v swww >/dev/null 2>&1 && [[ -d "$HOME/Pictures/wallpapers" ]]; then
        mapfile -t _walls < <(find "$HOME/Pictures/wallpapers" -type f 2>/dev/null)
        if ((${#_walls[@]})); then
            swww img "${_walls[RANDOM % ${#_walls[@]}]}" --fill
        fi
    fi
elif [[ -x "$HOME/bin/bash_scripts/random-wallpaper.sh" ]]; then
    "$HOME/bin/bash_scripts/random-wallpaper.sh"
fi

if command -v mpd >/dev/null 2>&1; then
    systemctl --user start mpd.service 2>/dev/null || true
fi
