#!/usr/bin/env bash
# Wayland session extras started from niri/config.kdl

set -euo pipefail

mkdir -p "$HOME/Pictures/screenshots" "$HOME/.cache"

# Night colour (Wayland) — same settings as ~/.config/redshift/redshift.conf
GAMMASTEP_CONF="${HOME}/.config/gammastep/config.ini"
if command -v gammastep >/dev/null && [[ -f "$GAMMASTEP_CONF" ]]; then
    (
        sleep 2
        pkill -x gammastep 2>/dev/null || true
        gammastep -c "$GAMMASTEP_CONF" >>"$HOME/.cache/gammastep.log" 2>&1
    ) &
fi

if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
    # Stop global wallpaper cycler (BSPWM-style loop); niri uses per-workspace wallpapers.
    lock="/tmp/random-wallpaper.sh.wayland.${WAYLAND_DISPLAY}.lock"
    if [[ -f "$lock" ]]; then
        oldpid=$(<"$lock" 2>/dev/null || true)
        [[ -n "$oldpid" ]] && kill "$oldpid" 2>/dev/null || true
        rm -f "$lock"
    fi

    if [[ -x "$HOME/.config/niri/scripts/workspace-wallpaper.sh" ]]; then
        command -v awww >/dev/null && awww kill >/dev/null 2>&1 || true
        "$HOME/.config/niri/scripts/workspace-wallpaper.sh" daemon \
            >>"$HOME/.cache/niri-workspace-wallpaper.log" 2>&1 &
    elif [[ -x "$HOME/bin/bash_scripts/random-wallpaper.sh" ]]; then
        WALLPAPER_BACKEND=wayland "$HOME/bin/bash_scripts/random-wallpaper.sh" \
            >>"$HOME/.cache/niri-wallpaper.log" 2>&1 &
    fi
fi

if command -v mpd >/dev/null 2>&1; then
    systemctl --user start mpd.service 2>/dev/null || true
fi
