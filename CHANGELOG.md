# Changelog

All notable changes to this dotfiles repo are documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).  
Versions are dated milestones, not semver releases (this is a personal config repo).

## [2026-11-11] — Documentation overhaul (branch: `modernize-2026`)

### Added
- Rewrote the main **`README.md`**: hero, gallery, a complete grouped component inventory (every tool linked), a Neovim deep-dive, install guide, and collapsible keybinding cheatsheets.
- A **per-component README** for nearly every tool, written in a consistent, concise voice straight from the real configs (accurate keybinds/deps, with honest caveats kept).
- **Hero headers** on the signature and medium/large tools — tool logo, upstream link, live GitHub stars badge, license, and a soft author credit; tools with no official logo get a clean typographic hero. Logos committed under `assets/`.
- `docs/firefox.md`.

### Changed
- Trimmed component READMEs to essentials (intro + keybinding/usage tables); dropped most per-tool "Setup" sections.

### Removed
- Thin/redundant component READMEs: `urlscan`, `urlview`, `Kvantum`, `vivid`, `gammastep`, `scripts`.
- Main README "Making It Yours" and "Maintenance" sections.

## [2026-11-09] — Modernization & dead-tool cleanup (branch: `modernize-2026`)

### Changed
- Dead tools → maintained forks: `exa`→`eza`, `youtube-dl`→`yt-dlp`, `sxiv`→`nsxiv`, `rtv`→`tuir`, `ag`→`rg` (FZF command)
- Neovim consolidated onto **snacks.nvim** (picker / explorer / notifier); dropped the noice, oil, dressing, mini.nvim, mini.icons, fzf-lua, mini.pick overlaps
- mpv `sub-ass-force-style`→`sub-ass-style-overrides`; dunst `geometry`→`width`/`height`/`origin`/`offset`; picom dropped removed keys (`dbe`, `glx-copy-from-front`)
- polybar network modules use `interface-type = wireless` (auto-detect) instead of hardcoded `wlan0`
- Alacritty: removed invalid top-level `theme=` / misplaced `title=` keys
- Package manifests: dropped `neofetch`/`screenfetch`, `ueberzug`→`ueberzugpp`, `sxiv`→`nsxiv`
- `vivid` LS_COLORS cached instead of regenerated every shell; `JAVA_HOME` guarded to Arch default JDK

### Fixed
- Neovim latent bug: packer-era `requires=`/`after=` keys that lazy.nvim silently ignored → proper `dependencies`
- Neovim keybinds repointed from Telescope/Oil to snacks (would have errored on keypress)
- yazi: invalid commands (`find_next`, `atime/ctime` sorts, `show-info`), `%s`→`$@` openers, and an invalid multi-line inline table (TOML)
- dunst: removed foreign `/home/leon/.nix-profile` dmenu path + dead gnome icon paths
- sxhkd: workspace bind `{1-8}`→`{1-9}` (desktop 九 was unreachable); removed shadowed duplicate `super+space`
- Transmission: RPC bound to `127.0.0.1` (was `0.0.0.0`); `$USER`/`$HOME` literal paths → absolute (exempted in `validate.sh`)
- Hardcoded foreign usernames (`/home/precision`, `/home/wasif`) → `$HOME`

### Removed
- Neovim dead code: `config/*.vimrc` tree, `UltiSnips/` (no loader), 10 orphaned `plugins/*.lua` (~2,500 lines)
- `.Xresources`: dead `~/etc/...` include + unused URxvt block (kept the `Xft.*` hints)

### Added
- `docs/firefox.md` (referenced by `setup.sh`/CHANGELOG but previously missing)

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
