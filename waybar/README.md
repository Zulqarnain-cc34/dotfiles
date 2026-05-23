# Waybar

Layout mirrors `polybar/config.ini`:

| Polybar module | Waybar module |
|----------------|---------------|
| launcher | custom/launcher |
| mod | custom/mod |
| bspwm | niri/workspaces |
| networkspeedup / down | custom/net-up / net-down |
| battery | battery |
| mpd | mpd |
| date | clock |
| uptime | custom/uptime |
| cpu_bar | cpu |
| memory_bar | memory |
| filesystem_bar | disk |
| volume | pulseaudio |
| backlight | backlight |
| tray | tray |
| powermenu | custom/powermenu |

## Hardware paths

Edit `config.jsonc` if your system differs from polybar defaults:

- Network interface: `WAYBAR_NET_IFACE=wlan0` (or edit `scripts/net-speed.sh`)
- Backlight: `"device": "intel_backlight"` in `backlight` module
- Battery: `"bat": "BAT0"`

## Notes

Icons use **Iosevka Nerd Font** (same as polybar `font-0`).
