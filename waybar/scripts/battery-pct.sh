#!/usr/bin/env bash
# Battery percentage label for waybar (icon is separate battery module)

bat="${WAYBAR_BAT:-BAT0}"
base="/sys/class/power_supply/${bat}"
cap="${base}/capacity"

[[ -r "$cap" ]] || { echo "N/A"; exit 0; }

pct=$(< "$cap")

# Some drivers report capacity >100 when charge_now > charge_full (miscalibrated).
if [[ -r "${base}/charge_now" && -r "${base}/charge_full" ]]; then
    cn=$(< "${base}/charge_now")
    cf=$(< "${base}/charge_full")
    if (( cf > 0 )); then
        pct=$(( cn * 100 / cf ))
    fi
fi

(( pct > 100 )) && pct=100
(( pct < 0 )) && pct=0

echo "${pct}%"
