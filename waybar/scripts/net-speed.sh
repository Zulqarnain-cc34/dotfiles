#!/usr/bin/env bash
# Network upload/download speed for waybar (polybar networkspeedup/down)

set -euo pipefail

direction="${1:-down}"
iface="${WAYBAR_NET_IFACE:-wlan0}"
dir="${XDG_CACHE_HOME:-$HOME/.cache}/waybar"
state="${dir}/net-${iface}.state"
rate_up="${dir}/net-${iface}.up"
rate_down="${dir}/net-${iface}.down"
lock="${dir}/net-${iface}.lock"

mkdir -p "$dir"

human_rate() {
    awk -v b="$1" 'BEGIN {
        if (b >= 1048576) printf "%.1fM", b/1048576;
        else if (b >= 1024) printf "%.1fK", b/1024;
        else printf "%dB", b;
    }'
}

print_rate() {
    if [[ "$direction" == "up" ]]; then
        [[ -f "$rate_up" ]] && cat "$rate_up" || echo "0B"
    else
        [[ -f "$rate_down" ]] && cat "$rate_down" || echo "0B"
    fi
}

if [[ ! -r "/sys/class/net/${iface}/statistics/rx_bytes" ]]; then
    echo "N/A"
    exit 0
fi

exec 200>"$lock"
if ! flock -n 200; then
    print_rate
    exit 0
fi

rx=$(< "/sys/class/net/${iface}/statistics/rx_bytes")
tx=$(< "/sys/class/net/${iface}/statistics/tx_bytes")
now=$(date +%s%3N)

if [[ -f "$state" ]]; then
    read -r prev_rx prev_tx prev_now < "$state" || true
    dt=$((now - prev_now))
    if (( dt > 0 )); then
        up_rate=$(( (tx - prev_tx) * 1000 / dt ))
        down_rate=$(( (rx - prev_rx) * 1000 / dt ))
        (( up_rate < 0 )) && up_rate=0
        (( down_rate < 0 )) && down_rate=0
        human_rate "$up_rate" > "$rate_up"
        human_rate "$down_rate" > "$rate_down"
    fi
fi

echo "$rx $tx $now" > "$state"
print_rate
