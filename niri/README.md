# Niri (Wayland compositor)

Scrollable-tiling Wayland session alongside the existing BSPWM/X11 setup. Config lives in this repo; X11 dotfiles are unchanged.

## Install packages

```bash
sudo pacman -S --needed $(grep -v '^#' packages/niri-wayland.txt | tr '\n' ' ')
```

Or install manually: `niri`, `waybar`, `wl-clipboard`, `cliphist`, `swaylock`, `grim`, `slurp`, `swww`, `gammastep`, `wireplumber`.

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
| `autostart.sh` | Wallpaper (`swww`) + optional MPD |

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

Niri-specific actions moved off conflicting keys: overview `Super+Shift+O`, tabbed column `Super+Shift+W`.

**Workspaces:** dynamic, not pre-declared names. Waybar maps index 1–9 to 一–九; empty workspaces are hidden via CSS (Arch waybar 0.15 has no `hide-empty` yet).

## Outputs / monitors

Edit `config.kdl` and uncomment/configure `output "NAME" { ... }` blocks after listing connectors:

```bash
niri msg outputs
```

## Notes

- **BSPWM stack** (picom, sxhkd, polybar, feh, redshift, clipmenud) is for X11 only.
- **Kitty** works on Wayland out of the box.
- Set **gammastep** latitude/longitude in `~/.config/gammastep/config.toml` (similar to `redshift/redshift.conf`).
- Wallpapers: place images in `~/Pictures/wallpapers` for `swww` in `autostart.sh`.
