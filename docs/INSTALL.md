# Installation

Full walkthrough. For the condensed version see the main [README](../README.md#-installation).

## Prerequisites

- **Arch Linux** (or an Arch-based distro)
- A **Nerd Font** — the config expects `ttf-jetbrains-mono-nerd` and `ttf-iosevka-nerd`
- `git`, `base-devel`, and an AUR helper (`yay`) for a few packages

## 1. Clone

```bash
git clone https://github.com/Zulqarnain-cc34/dotfiles.git ~/etc/linuxConfig/dotfiles_v2
cd ~/etc/linuxConfig/dotfiles_v2
chmod +x setup.sh scripts/*.sh
```

## 2. Install packages

Pick what you need from the newest snapshot under [`packages/`](../packages/) (`vN/`): `pacman-packages.txt` lists repo packages, `yay-packages.txt` the AUR ones. Install them with `pacman` and `yay`.

## 3. Bootstrap secrets

```bash
./scripts/bootstrap-secrets.sh
```

Copies gitignored `.example` templates into their real paths (`.gitconfig`, the rofi ribbon colour theme, `transmission-daemon/settings.json`) if they don't already exist. Run this *before* step 4 so the real files exist to be linked. Details: [`docs/secrets.md`](secrets.md).

## 4. Symlink configs

```bash
./setup.sh --backup
```

Flags:

| Flag | Effect |
|---|---|
| *(none)* | Link only where the target doesn't already exist |
| `--backup` | Copy existing targets to `~/.dotfiles_backup/<timestamp>/` first |
| `--force` | Remove and replace existing targets — use with care |
| `--dry-run` | Print what would happen; touches nothing |
| `--check` | Report per-target drift (ok / missing / wrong); touches nothing |

Firefox is **not** symlinked by this script — see [`docs/firefox.md`](firefox.md) for why and how to apply its theme instead.

## 5. Enable hooks and validate

```bash
git config core.hooksPath .githooks
./scripts/validate.sh
```

`validate.sh` runs a fast sanity pass (secret-path check + staged gitleaks scan) by default. `--history` scans full git history (slow); `--full` scans the whole working tree (~60s).

## 6. Neovim plugins

```bash
nvim +Lazy sync +qa
```

Syncs the lazy.nvim plugin set on first run so the editor isn't doing it mid-session later.
