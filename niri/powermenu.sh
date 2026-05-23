#!/usr/bin/env bash
# Powermenu for niri / Wayland (polybar script uses bspc + xflock4)

MENU="$(rofi -dmenu -i -p 'System' -show-icons -icon-theme Papirus \
    <<< $'Lock\nLogout\nSuspend\nReboot\nShutdown')"

case "$MENU" in
    Lock) swaylock ;;
    Logout) niri msg action quit ;;
    Suspend) systemctl suspend ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl -i poweroff ;;
esac
