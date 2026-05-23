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

stop_wallpaper_daemons() {
    pkill -f 'bash_scripts/random-wallpaper\.sh$' 2>/dev/null || true
    pkill -f 'workspace-wallpaper\.sh daemon' 2>/dev/null || true
    rm -f "$HOME/.cache/niri-workspace-wallpaper.lock"
    rm -f "/tmp/random-wallpaper.sh.wayland.${WAYLAND_DISPLAY}.lock"
}

if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
    stop_wallpaper_daemons
    sleep 0.3
    stop_wallpaper_daemons

    if [[ -x "$HOME/.config/niri/scripts/workspace-wallpaper.sh" ]]; then
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
