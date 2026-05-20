# Host scripts (`~/bin/bash_scripts/`)

Vendored in the repo as **`bash_scripts/`** and symlinked by `setup.sh`:

```text
~/bin/bash_scripts  →  <dotfiles>/bash_scripts
```

Full index: [bash_scripts/README.md](../../bash_scripts/README.md).

## Session-critical

| Script | Used by |
|--------|---------|
| `urlportal.sh` | `.profile`, `newsboat/config` |
| `random-wallpaper.sh` | `bspwm/bspwmrc` autostart |
| `ytfzf` | `sxhkd` (`super+y`), `rofi/launchers/rofi-bangs` |
| `notifytorrents` | `sxhkd` (`shift+alt+t`) |
| `killandnotify` | `sxhkd` (config reload notify) |

## Optional

| Path | Used by |
|------|---------|
| `scripts/wallpaper.sh` | `lf/lfrc`, `vivid/keymap.toml` |
| `scripts/calcurse-mutt.sh` | `.mutt/mailcap` (commented) |

Legacy minimal stubs (if not using the full `bash_scripts/` tree): [stubs/](stubs/).
