# Conky

A lightweight system monitor that draws straight onto the X11 desktop — the panel of live stats sitting quietly off to one side of the wallpaper. Only `conky1` is wired into this session, autostarted from `bspwm/bspwmrc`.

The active widget, [`conky1/conkyrc1`](conky1/conkyrc1), is a middle-right panel that reports clock and date, SYSTEM (kernel, uptime, load), PROCESSOR (processes and threads, with a CPU bar and graph), MEMORY (RAM and swap bars), FILESYSTEMS (`/` and `/home`), and NETWORK — the last of which auto-detects the active interface through `if_existing` blocks covering eth0, wlan0, enp0s0, enp2s0, and wlp2s0. It renders as an ARGB desktop-type window (`own_window_type desktop`, `own_window_argb_visual yes`), which is X11-only and won't show up under Wayland.

Two other themes come along for the ride but aren't launched: `conky2/` is an alternate system-info layout, and `conky3/` is the "InfinitySVG" theme (with its own `startconky.sh` and a Lua clock-rings script, `scripts/haunted.lua`).

### Setup

You just need `conky` (the X11 build); conky3 additionally wants the Lua clock-rings script to run its rings. The files:

- [`conky1/conkyrc1`](conky1/conkyrc1) — the config `bspwmrc` loads (`conky -q -c ~/.config/conky/conky1/conkyrc1`).
- `conky2/conkyrc2` — the unused alternate system-info theme.
- `conky3/` — the "InfinitySVG" theme: `conkyrc`, `startconky.sh`, `scripts/haunted.lua`, and `background.png`.

Fonts, colours, and position all live in `conky1/conkyrc1` — `xftfont`, `default_color`, and the `alignment`/`gap_x`/`gap_y` lines. To swap which widget runs at startup, change the conky line in `bspwm/bspwmrc`.
