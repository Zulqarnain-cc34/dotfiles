# Changelog

All notable changes to this dotfiles repo are documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).  
Versions are dated milestones, not semver releases (this is a personal config repo).

## [2026-11-12] — Yazi keymap fixes & smart extraction (branch: `modernize-2026`)

### Fixed
- `a,p`/`a,z`/`a,t`/`a,g`/`a,b`/`a,u`/`b,g`: all read yazi's selected-file placeholder via `$1`/`$@`/`${!#}` — those are shell positional params and are never set in yazi's `run` strings (only `%h`/`%s`/`%1`/`%d1` are text-substituted in). Replaced with the correct placeholders throughout.
- `a,z`/`a,t`/`a,g`/`a,b`: archive creation baked in the full absolute path and could silently clobber a same-named output; now packs by basename (no leading path) and auto-renames on collision (`-1`, `-2`, ...).
- `[opener]`/`e,e`/`e,i`/`e,g`: redundant manual quoting around already-quoted `%s`/`%1` (doubled quotes broke filenames containing spaces/pipes), and a missing `--block` left `nvim`/`exiftool | less` running detached instead of taking over the terminal.

### Removed
- Dead `[mgr] keymap` binding on `w` ("Set directory and exit", wrote `$YAZI_CWD` to `/tmp/yazi_cwd`) — `prepend_keymap` binds `w` to `quit` too and is matched first, so this one never fired. Confirmed live: pressing `w` quit without creating the file. `/tmp/yazi_cwd` wasn't read anywhere else in the repo either.

### Added
- `yazi/smart-extract.sh`, bound to `a,u`: extracts into the current directory with no wrapper folder when an archive already has a single top-level folder (matches 7-Zip/Nautilus/Archive Utility convention); otherwise wraps the contents in a new folder named after the archive, auto-renamed on collision. Non-archive files in a mixed selection are skipped, not fatal.

Verified by driving the real `yazi` binary end-to-end (real keystrokes, real screenshots), not just testing scripts standalone.

## [2026-11-12] — Security & repo hygiene hardening (branch: `modernize-2026`)

### Security
- `transmission-daemon/settings.json`, which carried a real `rpc-password` hash, is no longer tracked. It's now generated from a sanitized `settings.json.example` by `scripts/bootstrap-secrets.sh` (same pattern already used for `.gitconfig` and the rofi ribbon colours).
- `scripts/validate.sh`: added a guard so `transmission-daemon/settings.json` fails validation if it's ever re-tracked; added a check that fails on any committed compiled binary (ELF/Mach-O/PE32).
- Removed `eval` from `bash_scripts/scripts/rofi-klipper.sh` — none of the calls needed shell re-parsing, so this closes an unnecessary injection surface.

### Removed
- ~30MB of committed Transmission blocklist data (`transmission-daemon/blocklists/*.p2p*`) — it's fetched at runtime via `settings.json`'s `blocklist-url` and never needed to be in git.
- A compiled binary (`bash_scripts/scripts/greenclip`) that dotfiles should never ship.
- `bash_scripts/scripts/autostart.sh` — an orphaned, unreferenced file (the real autostart lives in `bspwm/bspwmrc`); it also carried the dead binary call above and the deprecated picom `--experimental-backends` flag.

### Added
- `.gitattributes`: line-ending normalization, binary markers for images/fonts, and `linguist-vendored`/`linguist-generated` on third-party code (firefox-sweet-theme, qutebrowser greasemonkey scripts, yazi flavor packs, fish's generated functions).
- `setup.sh --dry-run`: prints every planned action with zero filesystem writes.
- `setup.sh --check`: reports per-target drift (ok / drift / missing) with zero filesystem writes.
- A live CI "secrets scan" badge on the main README.

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
