<div align="center">
  <img src="../assets/conky.png" width="240" alt="Conky logo"><br><br>
  <p><em>A lightweight system monitor drawn on the desktop.</em></p>
  <a href="https://github.com/brndnmtthws/conky"><img src="https://img.shields.io/badge/upstream-brndnmtthws%2Fconky-3b4252?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/brndnmtthws/conky/stargazers"><img src="https://img.shields.io/github/stars/brndnmtthws/conky?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-GPL--3.0-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[Conky](https://conky.cc)** by Brenden Matthews & contributors. ❤️

A lightweight system monitor that draws straight onto the X11 desktop — the panel of live stats sitting quietly off to one side of the wallpaper. Only `conky1` is wired into this session, autostarted from `bspwm/bspwmrc`.

The active widget, [`conky1/conkyrc1`](conky1/conkyrc1), is a middle-right panel that reports clock and date, SYSTEM (kernel, uptime, load), PROCESSOR (processes and threads, with a CPU bar and graph), MEMORY (RAM and swap bars), FILESYSTEMS (`/` and `/home`), and NETWORK — the last of which auto-detects the active interface through `if_existing` blocks covering eth0, wlan0, enp0s0, enp2s0, and wlp2s0. It renders as an ARGB desktop-type window (`own_window_type desktop`, `own_window_argb_visual yes`), which is X11-only and won't show up under Wayland.

Two other themes come along for the ride but aren't launched: `conky2/` is an alternate system-info layout, and `conky3/` is the "InfinitySVG" theme (with its own `startconky.sh` and a Lua clock-rings script, `scripts/haunted.lua`).

### Setup

You just need `conky` (the X11 build); conky3 additionally wants the Lua clock-rings script to run its rings. The files:

- [`conky1/conkyrc1`](conky1/conkyrc1) — the config `bspwmrc` loads (`conky -q -c ~/.config/conky/conky1/conkyrc1`).
- `conky2/conkyrc2` — the unused alternate system-info theme.
- `conky3/` — the "InfinitySVG" theme: `conkyrc`, `startconky.sh`, `scripts/haunted.lua`, and `background.png`.
