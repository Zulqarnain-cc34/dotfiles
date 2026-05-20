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

See also [scripts/host/README.md](../scripts/host/README.md) for the short index.