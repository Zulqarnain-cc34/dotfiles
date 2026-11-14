<div align="center">
  <h1>BSPWM</h1>
  <p><em>The tiling window manager — binary space partitioning, scripted via <code>bspc</code>.</em></p>
  <a href="https://github.com/baskerville/bspwm"><img src="https://img.shields.io/badge/upstream-baskerville%2Fbspwm-1a1b26?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/baskerville/bspwm/stargazers"><img src="https://img.shields.io/github/stars/baskerville/bspwm?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-BSD--2--Clause-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
  <br><br>
  <img src="../assets/desktop-4.png" width="82%" alt="BSPWM desktop">
</div>

> Powered by **[bspwm](https://github.com/baskerville/bspwm)** by Bastien Dejean (baskerville). ❤️

A tiling window manager that splits space in two, over and over — the primary X11 session here, kept deliberately tight with thin borders and barely-there gaps.

One monitor, nine desktops labelled with CJK numerals (`一 二 三 四 五 六 七 八 九`), `border_width` and `window_gap` both 2, an even `split_ratio` of 0.50, and monocle mode that drops borders and gaps for a clean fullscreen.

### Keybindings

Hotkeys live in **[sxhkd](../sxhkd)**, started from `bspwmrc` (daemons are `pgrep`-guarded, so a `bspc wm -r` reload never spawns duplicates).

### Setup

Needs `bspwm` + `sxhkd`; the autostart also pulls in `picom`, `dunst`, `redshift`, `clipmenu`, `polybar`, and `conky`. Terminal is `kitty` (`$TERMINAL`).

It's all one script, [`bspwmrc`](bspwmrc) — which **must be executable** (`chmod +x bspwmrc`), or bspwm silently ignores it and starts with defaults.
