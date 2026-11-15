# Host scripts (`bash_scripts/`)

Deployed by `setup.sh` as **`~/bin/bash_scripts`** (on `PATH` via `.profile` / `zsh/.zshenv`).

## Session-critical (must exist)

| Path | Used by |
|------|---------|
| `urlportal.sh` | `.profile`, `newsboat/config` |
| `random-wallpaper.sh` | `bspwm/bspwmrc` |
| `ytfzf` | `sxhkd`, `rofi/launchers/rofi-bangs` |
| `notifytorrents` | `sxhkd` (`shift+alt+t`) |
| `killandnotify` | `sxhkd` (reload notification) |

## Optional / paths you may add locally

| Path | Used by |
|------|---------|
| `personal/*` | legacy paths in some scripts |
| `scripts/wallpaper.sh` | `lf/lfrc`, `vivid/keymap.toml` |

## Bundled binaries

| Path | What |
|------|------|
| `csakura` | Symlink that keeps the cherry-blossom screensaver on `PATH`. The real binary, source and writeup now live in [`../csakura/`](../csakura/). |

See also [scripts/host/README.md](../scripts/host/README.md) for the short index.

## Note

Most of these scripts are not originally mine. I've collected them from various sources over time and made some changes to fit my setup. I don't remember all the original authors, but I've credited a few in the main README.
