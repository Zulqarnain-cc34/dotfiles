# imv

A lightweight, keyboard-driven image viewer for X11 — the default image viewer here, with Vim-style motions and a hook into the pywal colour workflow so any picture on screen can become the desktop palette.

All of imv's built-in binds are suppressed and redefined explicitly, images sit on a dark `#1F1F21` background with no scaling, and a small title hook keeps things oriented: it uses `xdotool` to show `[ index / count ] : dirname` in the titlebar and caches the current position per directory under `~/.cache/imv/`, so reopening a folder lands you where you left off.

### Keybindings

The full set, defined in [`config`](config):

| Key | Action |
|-----|--------|
| `q` | Quit |
| `h` / `l` | Previous / next image |
| `gg` / `Shift+G` | First / last image |
| `j` / `k` | Pan down / up |
| `Left` / `Right` | Pan horizontally |
| `Up` `i` `Shift++` | Zoom in |
| `Down` `o` `-` | Zoom out |
| `a` | Zoom to actual size |
| `c` | Center image |
| `r` | Reset view |
| `f` | Toggle fullscreen |
| `d` | Toggle overlay |
| `s` / `Shift+S` | Cycle scaling / upscaling mode |
| `Shift+R` | Rotate 90° in place (via `mogrify`, edits the file) |
| `period` / `space` | Next GIF frame / toggle playback |
| `w` | Set colours from the image with `wal` (writes `bspwmrc`) |
| `m` | Append the file path to a tag list picked via `rofi` |
| `p` | Echo the current file path |

### Setup

Install `imv` for the viewer, plus the small cast of helpers the binds and title hook lean on: `xdotool` (titlebar), `python-pywal` for the `wal` colour grab, `imagemagick` for the in-place `mogrify` rotate, `rofi` for the tagging prompt, and `coreutils` (`base64` and friends) for the cache key.

Everything lives in [`config`](config): rebind under `[binds]`, change `background` or `scaling_mode` under `[options]`, or adjust the `title_text` hook to reshape the titlebar and cache behaviour.
