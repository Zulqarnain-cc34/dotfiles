# Host scripts (`bash_scripts/`)

Deployed by `setup.sh` as **`~/bin/bash_scripts`**. The top-level directory itself, plus each category subdirectory below, is on `PATH` (via `.profile` / `zsh/.zshenv`) — so every script here is callable by its bare name from a shell, not just by full path.

## Categories

| Directory | What's in it |
|-----------|---------------|
| [`media/`](media/) | Video, audio, wallpapers — `ytfzf`, `ytmp3`, `random-wallpaper.sh` |
| [`system/`](system/) | OSDs, toggles, daemons — volume/brightness OSD and status, `dunst-dnd-toggle.sh`, `xset-repeat-logger.sh`, `redshift_toggle.sh`, `low_bat_notifier.sh`, `conky-start.sh`, `pulsedevices`, `pulsevolctrl` |
| [`network/`](network/) | `postconnect`, `predisconnect` |
| [`torrents/`](torrents/) | `notifytorrents`, `tordone`, `torque`, `transadd`, `transclr` |
| [`files/`](files/) | `copy.sh`, `smart-extract.sh`, `lfmount`, `pdf-thumbnail.sh` |
| [`web/`](web/) | `urlportal.sh` |
| [`launchers/`](launchers/) | `aliasmanager.sh`, `killandnotify`, `rofi-bangs` (symlink into `rofi/launchers/`) |
| [`colorscripts/`](colorscripts/) | Loose, multi-author terminal color-art collection (not on `PATH`) |
| `csakura` | Symlink keeping the cherry-blossom screensaver on `PATH`. The real binary, source and writeup live in [`../csakura/`](../csakura/). |

## Session-critical (must exist)

| Path | Used by |
|------|---------|
| `web/urlportal.sh` | `.profile`, `newsboat/config` |
| `media/random-wallpaper.sh` | `bspwm/bspwmrc` |
| `media/ytfzf` | `sxhkd`, `rofi/launchers/rofi-bangs` |
| `torrents/notifytorrents` | `sxhkd` (`shift+alt+t`) |
| `launchers/killandnotify` | `sxhkd` (reload notification) |

## Optional / paths you may add locally

| Path | Used by |
|------|---------|
| `personal/*` | legacy paths in some scripts |

See also [scripts/host/README.md](../scripts/host/README.md) for the short index.

## Note

Most of these scripts are not originally mine. I've collected them from various sources over time and made some changes to fit my setup. I don't remember all the original authors, but I've credited a few in the main README.
