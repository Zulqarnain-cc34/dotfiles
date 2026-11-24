# Host scripts

Personal utility scripts for this setup, organized by category below. `setup.sh` deploys this directory as **`~/bin/bash_scripts`**.

## Categories

| Directory | What's in it |
|-----------|---------------|
| [`media/`](media/) | Video, audio, wallpapers — `ytfzf`, `ytmp3`, `random-wallpaper.sh` |
| [`system/`](system/) | OSDs, toggles, daemons — volume/brightness OSD and status, `dunst-dnd-toggle.sh`, `xset-repeat-logger.sh`, `redshift_toggle.sh`, `low_bat_notifier.sh`, `conky-start.sh`, `pulsedevices`, `pulsevolctrl` |
| [`network/`](network/) | `postconnect`, `predisconnect` |
| [`torrents/`](torrents/) | `notifytorrents`, `tordone`, `torque`, `transadd`, `transclr` |
| [`files/`](files/) | `copy.sh`, `smart-extract.sh`, `lfmount`, `pdf-thumbnail.sh` |
| [`web/`](web/) | `urlportal.sh` |
| [`launchers/`](launchers/) | `aliasmanager.sh`, `rofi-bangs` (symlink into `rofi/launchers/`) |
| [`colorscripts/`](colorscripts/) | Loose, multi-author terminal color-art collection (not on `PATH`) |
| `csakura` | Symlink keeping the cherry-blossom screensaver on `PATH`. The real binary, source and writeup live in [`../csakura/`](../csakura/). |

## Scripts

What each script does and what it's good for.

| Script | What it does | Features |
|--------|---------------|----------|
| `files/copy.sh` | Parallel `rsync` copy | worker pool, progress bar, dry-run, resumable |
| `files/smart-extract.sh` | Extracts an archive | single-root detection, collision-safe, multi-format |
| `files/lfmount` | Mounts/unlocks a block device | `fzf` picker, LUKS unlock, default mountpoint |
| `files/pdf-thumbnail.sh` | Renders a PDF thumbnail | first-page render, rofi preview |
| `media/random-wallpaper.sh` | Random wallpaper cycler | no-repeat picks, X11 only |
| `launchers/aliasmanager.sh` | Picks an alias and runs it | `fzf` picker, runs in current shell |
| `network/postconnect` | Starts `transmission-daemon` | NetworkManager dispatcher hook |
| `network/predisconnect` | Stops `transmission-daemon` | NetworkManager dispatcher hook |
| `web/urlportal.sh` | Routes a URL to the right opener | type-based dispatch, DuckDuckGo redirect decoding |

## Note

Most of these scripts are not originally mine. I've collected them from various sources over time and made some changes to fit my setup. I don't remember all the original authors, but I've credited a few in the main README.
