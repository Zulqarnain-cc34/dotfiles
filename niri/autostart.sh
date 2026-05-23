#!/usr/bin/env bash
# Wayland session extras started from niri/config.kdl

set -euo pipefail

mkdir -p "$HOME/Pictures/screenshots" "$HOME/.cache"

if [[ -x "$HOME/bin/bash_scripts/random-wallpaper.sh" && -n "${WAYLAND_DISPLAY:-}" ]]; then
    lock="/tmp/random-wallpaper.sh.wayland.${WAYLAND_DISPLAY}.lock"
    if [[ -f "$lock" ]]; then
        oldpid=$(<"$lock" 2>/dev/null || true)
        if [[ -n "$oldpid" ]] && kill -0 "$oldpid" 2>/dev/null; then
            kill "$oldpid" 2>/dev/null || true
            sleep 0.2
        fi
        rm -f "$lock"
    fi

    command -v awww >/dev/null && awww kill >/dev/null 2>&1 || true

    : >"$HOME/.cache/niri-wallpaper.log"
    WALLPAPER_BACKEND=wayland "$HOME/bin/bash_scripts/random-wallpaper.sh" \
        >>"$HOME/.cache/niri-wallpaper.log" 2>&1 &
fi

if command -v mpd >/dev/null 2>&1; then
    systemctl --user start mpd.service 2>/dev/null || true
fi
