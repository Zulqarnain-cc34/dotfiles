# Changelog

All notable changes to this dotfiles repo are documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).  
Versions are dated milestones, not semver releases (this is a personal config repo).

## [Unreleased]

### Added
- `bash_scripts/` vendored → `~/bin/bash_scripts` via `setup.sh`
- `setup.sh` flags: `--backup`, `--force`, `--help`
- `scripts/`: `bootstrap-secrets.sh`, `validate.sh`, `install-deps.sh`
- `docs/`: `INSTALL.md`, `secrets.md`, `firefox.md`
- `SECURITY.md`, `.gitleaks.toml`, `.githooks/pre-commit`, `.github/workflows/secrets.yml`
- `.gitconfig.example`, `packages/minimal.txt`

### Changed
- `setup.sh` uses `ln -sfn`, skips missing repo paths, links `.zprofile`
- Gitignore **only** `rofi/launchers/ribbon/styles/colors.rasi` (dynamic theme switcher); add `colors.rasi.example`
- README/sxhkd sync; `TERMINAL=kitty`; bspwm profiles; dunst cleanup; gmail retired; lazy-lock tracked
- Removed bulk `rofi/themes/` and `zsh/themes/`; ribbon launcher is primary rofi UI
- Restored `bootstrap-secrets.sh`, `docs/secrets.md`

### Removed
- `context.md` from git (local-only; listed in `.gitignore`)
- `scripts/purge-history.sh` — not needed for day-to-day use
- Portability: `$HOME` paths, `CONFIG_BACKUP`, wget, gcloud SDK, nvim undodir
- Polybar unified via `launch.sh`; maim screenshots; redshift config file

## [2026-05-15]

### Added
- Tracked config: `newsboat/urls`, `transmission-daemon/settings.json`, `.inputrc`, `twitchnotifier.cfg`
- `context.md` project documentation

## Notes

- **Day-to-day tweaks** (colors, plugins, keybinds): use `git log` — no need to log every commit here.
- **Log here when:** setup/install flow changes, secrets policy changes, breaking sxhkd/README behavior
