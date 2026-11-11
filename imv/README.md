# imv

A lightweight, keyboard-driven image viewer for X11 — the default image viewer here, with Vim-style motions and a hook into the pywal colour workflow so any picture on screen can become the desktop palette.

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
