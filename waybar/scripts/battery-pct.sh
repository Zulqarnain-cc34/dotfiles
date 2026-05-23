#!/usr/bin/env bash
# Battery percentage label for waybar (icon is separate battery module)

bat="${WAYBAR_BAT:-BAT0}"
cap="/sys/class/power_supply/${bat}/capacity"

[[ -r "$cap" ]] || { echo "N/A"; exit 0; }
echo "$(< "$cap")%"
