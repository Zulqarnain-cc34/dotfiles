# Niri (Wayland compositor)

Scrollable-tiling Wayland session alongside the existing BSPWM/X11 setup. Config lives in this repo; X11 dotfiles are unchanged.

## Install packages

```bash
sudo pacman -S --needed $(grep -v '^#' packages/niri-wayland.txt | tr '\n' ' ')
```

Or install manually: `niri`, `waybar`, `wl-clipboard`, `cliphist`, `swaylock`, `grim`, `slurp`, `awww`, `xwayland-satellite`, `gammastep`, `wireplumber`.

## Link configs

```bash
./setup.sh --force   # links niri/ and waybar/ into ~/.config/
chmod +x ~/.config/niri/autostart.sh
```

## Validate config

```bash
niri validate -c ~/.config/niri/config.kdl
```

## Start a session

**From a TTY:**

```bash
niri
```

**From a display manager:** pick a Niri session if your DM lists it, or add a session file:

```bash
# Example (adjust path to your niri binary if needed)
sudo cp /usr/share/wayland-sessions/niri.desktop /etc/X11/xinit/  # not always applicable
```

On Arch, `niri` package typically installs `/usr/share/wayland-sessions/niri.desktop`.

## What starts automatically

| Service | Role |
|---------|------|
| `dunst` | Notifications |
| `waybar` | Status bar (replaces polybar on Wayland) |
| `gammastep` | Night colour (Wayland replacement for redshift) |
| `wl-paste` + `cliphist` | Clipboard history |
| `autostart.sh` | Wallpaper (`awww`, cycles via `random-wallpaper.sh`) + optional MPD |

**X11 apps:** niri 25.08+ integrates `xwayland-satellite` automatically — no `spawn-at-startup` needed. On session start niri creates the X11 socket, sets `$DISPLAY`, and starts `xwayland-satellite` when the first X11 client connects (and restarts it if it dies). Verify with `echo $DISPLAY` inside a niri terminal; niri logs should show `listening on X11 socket: :N`.

## Keybindings

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

## Outputs / monitors

Monitor-switch keys do nothing with a single display. Check what niri sees:

```bash
niri msg outputs
```

You need **2+ outputs** and a **real niri session** (TTY or DM). Running `niri` inside a BSPWM terminal only gives one virtual screen.

For a docked/desktop setup, list connectors and add `output` blocks if needed:

```bash
niri msg outputs
```

## Notes

- **BSPWM stack** (picom, sxhkd, polybar, feh, redshift, clipmenud) is for X11 only.
- **Kitty** works on Wayland out of the box.
- Set **gammastep** latitude/longitude in `~/.config/gammastep/config.toml` (similar to `redshift/redshift.conf`).
- Wallpapers: same folder as BSPWM — `~/Pictures/Wallpapers/Wallpapers`. Wayland uses `awww` (`awww img --resize crop`). Logs: `~/.cache/niri-wallpaper.log`.
