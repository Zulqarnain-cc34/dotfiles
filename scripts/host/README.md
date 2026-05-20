# External scripts (`~/bin/bash_scripts/`)

These paths are **not** in this repo but are required for a full session. Install or clone your personal scripts repo to `$HOME/bin/bash_scripts/`, or copy minimal stubs from [`stubs/`](stubs/) (see [docs/INSTALL.md](../../docs/INSTALL.md) §6).

| Script | Used by |
|--------|---------|
| `random-wallpaper.sh` | `bspwm/bspwmrc` autostart |
| `urlportal.sh` | `.profile`, `newsboat/config` (default browser) |
| `newsboat/dangerzone/bookmark.sh` | `NEWSBOAT_BOOKMARKS` in `.profile` |
| `ytfzf` (or wrapper) | `sxhkd` (`super+y`), `rofi/launchers/rofi-bangs` |
| `personal/wallpaper.sh` | `lf/lfrc`, `vivid/keymap.toml` |
| `calcurse-mutt.sh` | `.mutt/mailcap` |
| `notifytorrents` | `sxhkd` (`shift+alt+t`) |

Optional helpers referenced in commented sxhkd blocks: `killandnotify`, `prompt`.

## Minimal stub example

```bash
mkdir -p ~/bin/bash_scripts
cat > ~/bin/bash_scripts/urlportal.sh <<'EOF'
#!/bin/sh
exec "${BROWSER:-firefox}" "$@"
EOF
chmod +x ~/bin/bash_scripts/urlportal.sh
```

Replace stubs with your real implementations over time.
