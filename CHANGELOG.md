# Changelog

All notable changes to this dotfiles repo are documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).  
Versions are dated milestones, not semver releases (this is a personal config repo).

## [Unreleased]

### Added
- **Niri (Wayland) session:** `niri/config.kdl`, `niri/autostart.sh`, `niri/powermenu.sh`, `niri/README.md`, `packages/niri-wayland.txt`
- **Waybar** for niri: `waybar/config.jsonc`, `waybar/style.css`, scripts (net speed, battery, uptime); polybar-style split icon + text modules
- **Gammastep** Wayland night colour: `gammastep/config.ini` linked via `setup.sh` (use in niri only — not redshift)
- **Per-workspace random wallpapers:** `niri/scripts/workspace-wallpaper.sh` + `awww` (new random image on every workspace switch via niri IPC)
- `xwayland-satellite` block in niri config for X11 apps on demand
- `bash_scripts/` vendored → `~/bin/bash_scripts` via `setup.sh`
- `setup.sh` flags: `--backup`, `--force`, `--help`; links `niri/`, `waybar/`, `gammastep/`; runs `disable-xdg-autostart.sh`
- `scripts/`: `bootstrap-secrets.sh`, `validate.sh`, `install-deps.sh`
- `docs/`: `INSTALL.md`, `secrets.md`, `firefox.md`
- `SECURITY.md`, `.gitleaks.toml`, `.githooks/pre-commit`, `.github/workflows/secrets.yml`
- `.gitconfig.example`, `packages/minimal.txt`

### Changed
- **BSPWM unchanged;** niri is an optional second session (`niri-session`, not bare `niri`)
- **Wallpapers:** `bash_scripts/random-wallpaper.sh` supports `awww` (Arch swww rename), `--pick` / `--set`, Wayland vs X11 locks; global cycler stopped in niri autostart
- **Gammastep** starts from `niri/autostart.sh` with explicit `-c`; `adjustment-method=drm` / `card=1` (wayland gamma failed on Intel i915)
- **Niri keybindings:** workspace/monitor/column navigation, overview on `Super+O`, htop on `Super+Shift+O`, sxhkd-style app binds
- **Waybar styling:** `spacing: 0`, transparent module boxes, tuned icon/text padding (right/center/left modules); disk icon ; left-side net/battery spacing
- **Kitty** `font_size` 11.5 (was 13)
- `setup.sh` uses `ln -sfn`, skips missing repo paths, links `.zprofile`
- Gitignore **only** `rofi/launchers/ribbon/styles/colors.rasi`; add `colors.rasi.example`
- README/sxhkd sync; `TERMINAL=kitty`; bspwm profiles; dunst cleanup; gmail retired; lazy-lock tracked
- Removed bulk `rofi/themes/` and `zsh/themes/`; ribbon launcher is primary rofi UI
- Restored `bootstrap-secrets.sh`, `docs/secrets.md`
- Portability: `$HOMgE` paths, `CONFIG_BACKUP`, wget, gcloud SDK, nvim undodir

### Removed
- Firefox from XDG autostart on author machine (`~/.config/autostart/firefox.desktop` entries — local, not in repo)
- Duplicate `spawn-at-startup "gammastep"` from niri config (handled in `autostart.sh`)
- `context.md` from git (local-only; listed in `.gitignore`)
- `scripts/purge-history.sh` — not needed for day-to-day use
- Polybar unified via `launch.sh`; maim screenshots

### Fixed
- Waybar workspace labels (niri `.focused` / CSS reset; was black on unfocused)
- Workspace wallpaper daemon not firing on switch (`WorkspaceActivated` events, not only `WorkspacesChanged`)
- Duplicate wallpaper daemons / global `random-wallpaper.sh` overriding niri per-switch wallpapers
- Two Firefox windows + junk apps on niri login (systemd XDG autostart)
- Waybar icon/text clipping on right-side and clock modules
- Battery waybar module showing >100% when `charge_now > charge_full`
- Firefox appearing zoomed in on niri (1.25× compositor scale + system DPI)

## [2026-05-15]

### Added
- Tracked config: `newsboat/urls`, `transmission-daemon/settings.json`, `.inputrc`, `twitchnotifier.cfg`
- `context.md` project documentation

## Notes

- **Day-to-day tweaks** (colors, plugins, keybinds): use `git log` — no need to log every commit here.
- **Log here when:** setup/install flow changes, secrets policy changes, breaking sxhkd/README behavior
