<div align="center">
  <img src="../assets/polybar.png" width="300" alt="Polybar logo"><br><br>
  <h1>Polybar</h1>
  <p><em>The status bar — one bar, custom modules, pure config.</em></p>
  <a href="https://github.com/polybar/polybar"><img src="https://img.shields.io/badge/upstream-polybar%2Fpolybar-3b4252?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/polybar/polybar/stargazers"><img src="https://img.shields.io/github/stars/polybar/polybar?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-MIT-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
  <br><br>
  <img src="../assets/polybar_demo.png" width="82%" alt="Polybar">
</div>

> Built on **[Polybar](https://polybar.github.io)** by the Polybar contributors. ❤️

> **Forking?** The `interface`, `BAT0`, and `intel_backlight` values across these `.ini` files are my hardware — swap them for yours.

A fast, configurable status bar for X11 — here it's a single top bar named `main`, launched alongside the BSPWM session and stretched across the full width of the screen.

The bar sits at the top at height 35, hooks into bspwm for WM-restack and IPC, and parks a system tray on the right (the 3.7 `internal/tray` module, not the deprecated bar-level `tray-*` settings). The modules are laid out in three groups:

- **left:** `launcher mod bspwm networkspeedup networkspeeddown battery`
- **center:** `mpd date`
- **right:** `uptime cpu_bar memory_bar filesystem_bar volume backlight powermenu systray`

Rather than one giant file, the config is split across includes — `colors.ini` for the palette, `bars.ini` for the progress-bar modules, `modules.ini` and `user_modules.ini` for everything else. One nice touch: the network modules use `interface-type = wireless`, so they auto-detect the wireless device instead of hardcoding `wlan0` or `wlp3s0`.
