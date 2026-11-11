<div align="center">
  <img src="../assets/polybar.png" width="300" alt="Polybar logo"><br><br>
  <h1>Polybar</h1>
  <p><em>The status bar — one bar, custom modules, pure config.</em></p>
  <a href="https://github.com/polybar/polybar"><img src="https://img.shields.io/badge/upstream-polybar%2Fpolybar-3b4252?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/polybar/polybar/stargazers"><img src="https://img.shields.io/github/stars/polybar/polybar?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-MIT-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
  <br><br>
  <img src="../screenshots/polybar.png" width="82%" alt="Polybar">
</div>

> Built on **[Polybar](https://polybar.github.io)** by the Polybar contributors. ❤️

> **Forking?** The audio sink names, Bluetooth MAC, `interface`, `BAT0`, and `intel_backlight` values across these `.ini` files are my hardware — swap them for yours.

A fast, configurable status bar for X11 — here it's a single top bar named `main`, launched alongside the BSPWM session and stretched across the full width of the screen.

The bar sits at the top at height 35, hooks into bspwm for WM-restack and IPC, and parks a system tray on the right. The modules are laid out in three groups:

- **left:** `launcher mod bspwm networkspeedup networkspeeddown battery`
- **center:** `mpd date`
- **right:** `uptime cpu_bar memory_bar filesystem_bar volume backlight powermenu`

Rather than one giant file, the config is split across includes — `colors.ini` for the palette, `bars.ini` for the progress-bar modules, `modules.ini` and `user_modules.ini` for everything else. One nice touch: the network modules use `interface-type = wireless`, so they auto-detect the wireless device instead of hardcoding `wlan0` or `wlp3s0`.

### Setup

You'll need `polybar` itself, and individual modules lean on a few more packages: `libpulse`/`pulseaudio` for volume, `mpd` for the music module, `networkmanager` (`nmd`/`nmcli`) for the network click actions, and `bspwm`. Fonts in use are `Iosevka Nerd Font`, `waffle`, `Noto Color Emoji`, and `Noto Sans CJK JP`.

The files, roughly in order of how often you'll touch them:

- [`config.ini`](config.ini) — the `main` bar definition, module layout, includes, and tray/scroll settings.
- [`colors.ini`](colors.ini) — the `[color]` palette (background `#282C34`, and so on).
- [`bars.ini`](bars.ini) — bar-progress glyphs plus the `volume`, `cpu_bar`, `filesystem_bar`, `memory_bar`, `bspwm`, `mod`, `date`, `network`, `brightness`, and `mpd_bar` modules.
- [`modules.ini`](modules.ini) — `battery`, `backlight`, and the active `mpd` module.
- [`user_modules.ini`](user_modules.ini) — custom scripts and menus: `uptime`, `launcher`, `powermenu`, `networkspeedup`/`down`, `mpv`, `weather`, `torrent`, and extra pulseaudio/mpd sinks.
- `launch.sh` — kills any running polybar, then starts the `main` bar.
- `scripts/`, `statusbar/` — helper scripts behind the custom modules (powermenu, updates, mpv, weather, torrent).

To re-colour, edit `colors.ini`; to change what shows up where, edit `modules-left/center/right` in `config.ini`. One caveat: the audio sinks for volume and headphones are hardcoded in `bars.ini`/`user_modules.ini` — look for the `HARDWARE-SPECIFIC` comments to point them at your own `pactl` sink name.
