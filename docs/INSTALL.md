# Installation (Arch Linux)

## 1. Clone

```bash
git clone git@github.com:Zulqarnain-cc34/dotfiles.git ~/etc/linuxConfig/dotfiles_v2
cd ~/etc/linuxConfig/dotfiles_v2
```

## 2. Packages

```bash
chmod +x setup.sh scripts/*.sh
./scripts/install-deps.sh
```

List: `packages/minimal.txt`

## 3. Symlinks

```bash
./setup.sh              # skip existing
./setup.sh --backup     # backup before linking missing targets
./setup.sh --force      # replace existing (careful)
```

Optional local git config (gitignored):

```bash
cp .gitconfig.example .gitconfig
```

## 4. Hooks & validate

```bash
git config core.hooksPath .githooks
./scripts/validate.sh
```

## 5. BSPWM monitors

Monitor profiles live under `bspwm/profiles/`:

- `default.sh` — single monitor, nine desktops (fallback)
- `desktop.sh` — author three-output layout (DisplayPort + HDMI)
- `laptop.sh.example` — copy to `profiles/$(uname -n).sh` (hostname) and edit

`bspwm/bspwmrc` loads `profiles/${DOTFILES_BSPWM_PROFILE:-$(uname -n)}.sh`, falling back to `default.sh`.

Default on author machine: `DOTFILES_BSPWM_PROFILE=desktop` in `.profile`.

Monitor names: `xrandr --query | grep ' connected'`

## 6. Host scripts & aliases

- **Scripts:** `bash_scripts/` → `~/bin/bash_scripts` via `setup.sh` (see [bash_scripts/README.md](../bash_scripts/README.md))
- **Shell aliases:** `~/.aliases/` → repo `.aliases/` via `setup.sh` (`aliases`, `functions`; sourced by zsh/bash)

## 6b. Redshift

Edit `redshift/redshift.conf` **lat/lon** for your city before relying on night colour temperature (repo defaults are Islamabad).

## 7. Primary tools

| Role | Tool |
|------|------|
| Terminal | Kitty (`TERMINAL=kitty`) |
| File manager | Yazi |
| Legacy file managers | lf, ranger (optional) |

## 8. Session

```bash
systemctl --user enable --now mpd.service   # optional
```

Start BSPWM from your display manager or `.xprofile`.

Neovim plugin pins are tracked in `nvim/lazy-lock.json` for reproducible installs; run `:Lazy sync` only when intentionally updating plugins.

## Docs

- [secrets.md](secrets.md) — local secrets policy, gitleaks
- [firefox.md](firefox.md) — Firefox theme install
- [../SECURITY.md](../SECURITY.md) — policy
