# Changelog

All notable changes to this dotfiles repo are documented here.

A simpler, more human variant of [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), without its Added/Changed/Fixed categories or semver versions — this is a personal config repo with one contributor, so that ceremony doesn't pull its weight here.
One entry per day, a few plain bullets on the main thing(s) done. The detailed record (what changed, why, how it was verified) lives in the git commit messages — see `git log` when you need that.

## [2026-11-18] — Today's session, in short

- Gave **fastfetch** a brand new look — sections, colors, icons, a proper font, and a working package count.
- Did a full **newsboat** audit and fixed what was broken (notifications, bookmarking, a few dead feeds).
- Added a **csakura** feature: the screensaver now dismisses on mouse movement too, not just a keypress.
- Set up a proper **GitHub workflow**: `develop`/`main` branches, and automatic account switching between profiles.

## [2026-11-16] — csakura build-on-setup, small reliability fixes

- Made csakura build itself from source during setup instead of shipping a committed binary.
- A batch of small reliability fixes: csakura's idle timeout, lf's preview columns, fastfetch's package count, and more robust polybar/wallpaper restarts.

## [2026-11-15] — Light maintenance

- Updated Neovim's plugin lockfile, refreshed the polybar demo image, and cleaned up a few unused aliases.

## [2026-11-14] — csakura screensaver, README credits, desktop-stack modernization

- Added the csakura cherry-blossom screensaver as a brand new feature.
- Reworked the main README's credits into a proper avatar grid after a full attribution audit.
- Modernized bspwm, sxhkd, picom, polybar, dunst, and rofi — fixed deprecated config options and cleared out dead files across the board.
- Fixed image-preview bugs in alacritty and kitty.

## [2026-11-13] — yazi/lf docs finished, full Neovim modernization

- Finished the yazi and lf documentation, with more real bugs found and fixed along the way (archive handling, bulk rename, dead keybindings).
- Did a full Neovim modernization: native LSP, Tree-sitter on the main branch, a cleaned-up plugin list, and a rewritten README.

## [2026-11-12] — Security hardening, deep yazi/lf/ranger audit

- Hardened repo security: stopped tracking a secret, removed a committed binary, and locked down the setup script.
- Did a deep audit of yazi, lf, and ranger — fixed real bugs in archive handling and keybindings, switched image previews to kitty, and wired up several plugins.

## [2026-11-11] — Documentation overhaul

- Wrote proper READMEs for almost every tool in the repo, with logos and hero headers.

## [2026-11-10] — Neovim keybinding update

- Small Neovim keybinding fix.

## [2026-11-09] — First modernization push

- Fixed broken shell and file-manager tools, cleaned up the X11 stack, modernized Neovim, and added install docs/infrastructure.

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
