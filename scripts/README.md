# Scripts

The handful of helper scripts that install, validate, and bootstrap this dotfiles repo — the plumbing behind `setup.sh`.

`install-deps.sh` installs the Arch package set from `packages/minimal.txt` via `sudo pacman -S --needed --noconfirm` (comments and blank lines are stripped first), and bows out with a hint if `pacman` isn't around. `validate.sh` runs non-destructive sanity checks: it confirms the required scripts and docs exist, that `packages/minimal.txt` uses `eza` rather than `exa`, that no tracked config hardcodes `/home/alpha`, that sensitive paths stay untracked, and that `bash_scripts/` and the active polybar module scripts are present — then it loads the nvim/polybar/sxhkd/bspwm configs and runs `gitleaks` (staged by default; `--history` or `--full` go deeper). `bootstrap-secrets.sh` creates the local-only, gitignored files from their templates, idempotently: `.gitconfig` from `.gitconfig.example`, and the rofi ribbon `colors.rasi` from its `.example`. It's normally invoked by `setup.sh`.

### host/

An index of the session-critical host scripts. The real ones are vendored as `bash_scripts/` and symlinked to `~/bin/bash_scripts` by `setup.sh`. `host/README.md` already exists and maps each script (`urlportal.sh`, `random-wallpaper.sh`, `ytfzf`, `notifytorrents`, `killandnotify`) to whatever uses it, and `host/stubs/` holds minimal fallback stubs for when you aren't running the full tree.

### Usage

```sh
./scripts/install-deps.sh      # install Arch packages
./scripts/validate.sh          # fast checks (index + staged gitleaks)
./scripts/validate.sh --full   # working-tree gitleaks scan (~60s)
```

`bootstrap-secrets.sh` usually runs via `setup.sh`, but you can run it standalone if needed. See `docs/secrets.md` for gitleaks findings and `docs/INSTALL.md` for the full setup.
