# Host scripts (`~/bin/bash_scripts/`)

Vendored in the repo as **`bash_scripts/`** and symlinked by `setup.sh`:

```text
~/bin/bash_scripts  →  <dotfiles>/bash_scripts
```

Full index: [bash_scripts/README.md](../../bash_scripts/README.md).

## Session-critical

| Script | Used by |
|--------|---------|
| `web/urlportal.sh` | `.profile`, `newsboat/config` |
| `media/random-wallpaper.sh` | `bspwm/bspwmrc` autostart |
| `media/ytfzf` | `sxhkd` (`super+y`), `rofi/launchers/rofi-bangs` |
| `torrents/notifytorrents` | `sxhkd` (`shift+alt+t`) |
| `launchers/killandnotify` | `sxhkd` (config reload notify) |

Minimal stubs (if not using the full `bash_scripts/` tree): [stubs/](stubs/).
