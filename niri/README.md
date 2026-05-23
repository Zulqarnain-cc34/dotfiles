# Niri (Wayland compositor)

Scrollable-tiling Wayland session.

### Install packages

```bash
sudo pacman -S --needed $(grep -v '^#' packages/niri-wayland.txt | tr '\n' ' ')
```

Or install manually: `niri`, `waybar`, `wl-clipboard`, `cliphist`, `swaylock`, `grim`, `slurp`, `awww`, `xwayland-satellite`, `gammastep`, `wireplumber`.

### Link configs

```bash
./setup.sh --force   # links niri/ and waybar/ into ~/.config/
chmod +x ~/.config/niri/autostart.sh
~/.config/niri/scripts/disable-xdg-autostart.sh
```

### What starts automatically

| Service | Role |
|---------|------|
| `dunst` | Notifications |
| `waybar` | Status bar (replaces polybar on Wayland) |
| `gammastep` | Night colour on Wayland (replaces redshift in niri) |
| `wl-paste` + `cliphist` | Clipboard history |
| `autostart.sh` | Per-workspace wallpapers + optional MPD |

### Keybindings

Mirrors your `sxhkd` habits where possible:

| Key | Action |
|-----|--------|
| `Super+Space` | rofi-bangs |
| `Super+Shift+Space` | Rofi ribbon launcher |
| `Super+T` | Kitty |
| `Super+R` | rtv |
| `Super+Y` | ytfzf |
| `Super+O` | Overview (all windows) |
| `Super+Shift+O` | htop |
| `Super+W` | Firefox |
| `Super+M` | neomutt |
| `Super+P` | Powermenu |
| `Super+D` | Toggle floating |
| `Super+F` | Maximize column |
| `Super+Q` | Close window |
| `Super+←/→` or `Super+H/L` | Focus column left/right (scrolls hidden columns in) |
| `Super+↑/↓` or `Super+K/J` | Focus window up/down in a column |
| `Super+Ctrl+←/→` or `Super+Ctrl+H/L` | Same — switch between columns/terminals in workspace |
| `Super+Ctrl+↑/↓` or `Super+Ctrl+K/J` | Switch between stacked windows in one column |
| `Super+Ctrl+Shift+arrows` | Move column/window (reorder layout) |
| `Super+1-9` | Focus workspace index 1–9 |
| `Super+Shift+1-9` | Move column to workspace index 1–9 |
| `Ctrl+Shift+Left/Right` | Move window to prev/next workspace (follows focus) |
| `Super+Shift+Left/Right` | Previous / next monitor (needs 2+ displays) |
| `Super+Shift+Up/Down` | Monitor above / below |
| `Super+V` | Clipboard history (cliphist + rofi) |
| `Alt+L` | swaylock |
| `Print` | Screenshot (niri) |
| `Shift+Print` | Region screenshot (grim + slurp) |
| `Super+Shift+X` | Reload niri config |

Niri-specific: tabbed column `Super+Shift+W`.

## Notes

- **BSPWM / X11:** `redshift` autostarts from `bspwm/bspwmrc` — config: `redshift/redshift.conf`
- **Niri / Wayland:** `gammastep` autostarts from `niri/config.kdl` — **do not run redshift in niri** (X11 only).