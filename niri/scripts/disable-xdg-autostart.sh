#!/usr/bin/env bash
# Niri pulls in systemd's xdg-desktop-autostart.target, which launches every
# ~/.config/autostart/*.desktop file (firefox, picom, sxhkd, nvim, redshift, …).
# Niri already starts what we need via spawn-at-startup in config.kdl.
set -euo pipefail

UNIT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
mkdir -p "$UNIT_DIR"
ln -sf /dev/null "$UNIT_DIR/xdg-desktop-autostart.target"

if command -v systemctl >/dev/null 2>&1; then
    systemctl --user daemon-reload 2>/dev/null || true
fi

echo "Disabled systemd XDG autostart (niri uses spawn-at-startup instead)."
