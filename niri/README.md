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
| `Super+O` | htop |
| `Super+W` | Firefox |
| `Super+M` | neomutt |
| `Super+P` | Powermenu |
| `Super+D` | Toggle floating |
| `Super+F` | Maximize column |
| `Super+Q` | Close window |
| `Super+1-9` | Focus workspace index 1–9 |
| `Super+Shift+1-9` | Move column to workspace index 1–9 |
| `Super+V` | Clipboard history (cliphist + rofi) |
| `Alt+L` | swaylock |
| `Print` | Screenshot (niri) |
| `Shift+Print` | Region screenshot (grim + slurp) |
| `Super+Shift+X` | Reload niri config |

Niri-specific actions moved off conflicting keys: overview `Super+Shift+O`, tabbed column `Super+Shift+W`..

## Outputs / monitors

Edit `config.kdl` and uncomment/configure `output "NAME" { ... }` blocks after listing connectors:

```bash
niri msg outputs
```

## Notes

- **BSPWM stack** (picom, sxhkd, polybar, feh, redshift, clipmenud) is for X11 only.
- **Kitty** works on Wayland out of the box.
- Set **gammastep** latitude/longitude in `~/.config/gammastep/config.toml` (similar to `redshift/redshift.conf`).
- Wallpapers: same folder as BSPWM — `~/Pictures/Wallpapers/Wallpapers`. Wayland uses `awww` (`awww img --resize crop`). Logs: `~/.cache/niri-wallpaper.log`.
