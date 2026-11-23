# Host scripts (`bash_scripts/`)

Personal utility scripts for this setup, organized by category below. `setup.sh` deploys this directory as **`~/bin/bash_scripts`**, and both it and each category subdirectory sit on `PATH` (via `.profile` / `zsh/.zshenv`), so any script here runs by its bare name from a shell.

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

## Reviewed

Scripts that have been through a full live-test pass (part of an ongoing script-by-script audit), with what each one does and where it's wired.

| Script | What it does | Used by |
|--------|---------------|---------|
| `files/copy.sh` | Parallel `rsync` copy with a worker pool, progress bar, and dry-run | run by bare name |
| `files/smart-extract.sh` | Extracts an archive directly if it's already single-rooted, otherwise wraps it in a new folder | `lf`, `yazi`, `ranger` (`au`) |
| `files/lfmount` | Interactive block-device mount/unlock helper (`fzf` + `lsblk` + `udisksctl`) | run by bare name |
| `files/pdf-thumbnail.sh` | Renders a PDF's first page as a thumbnail via `pdftoppm` | `rofi/launchers/rofi-books` |
| `media/random-wallpaper.sh` | Random wallpaper cycler for X11, skips repeating the last pick | `bspwm/bspwmrc` |

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
