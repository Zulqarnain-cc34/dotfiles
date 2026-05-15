#!/usr/bin/env bash
# Symlink dotfiles into ~/.config and $HOME.
#
# Usage:
#   ./setup.sh              Link only where target does not exist
#   ./setup.sh --backup     Backup existing targets before linking
#   ./setup.sh --force      Replace existing files/dirs/symlinks
#   ./setup.sh --backup --force
#
# Firefox: not symlinked — see docs/firefox.md
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP=0
FORCE=0

for arg in "$@"; do
    case "$arg" in
        --backup) BACKUP=1 ;;
        --force)  FORCE=1 ;;
        -h|--help)
            cat <<'EOF'
Usage: ./setup.sh [--backup] [--force]

  --backup  Copy existing targets to ~/.dotfiles_backup/<timestamp>/ first
  --force   Remove and replace existing targets (use with care)

After setup:
  git config core.hooksPath .githooks
  ./scripts/validate.sh
EOF
            exit 0
            ;;
        *) echo "Unknown option: $arg (try --help)" >&2; exit 1 ;;
    esac
done

backup_target() {
    local dest=$1
    [[ "$BACKUP" -eq 0 || ! -e "$dest" ]] && return 0
    local dir="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$dir"
    cp -a "$dest" "$dir/"
    echo "  backed up: $dest -> $dir/"
}

link_path() {
    local src=$1 dest=$2
    if [[ ! -e "$src" ]]; then
        echo "  skip (missing in repo): $src"
        return 0
    fi
    if [[ -e "$dest" || -L "$dest" ]]; then
        if [[ "$FORCE" -eq 1 ]]; then
            backup_target "$dest"
            rm -rf "$dest"
        else
            echo "  skip (exists): $dest"
            return 0
        fi
    fi
    mkdir -p "$(dirname "$dest")"
    ln -sfn "$src" "$dest"
    echo "  linked: $dest -> $src"
}

link_dir()  { link_path "$ROOT/$1" "$2"; }
link_file() { link_path "$ROOT/$1" "$2"; }

echo "==> Repository: $ROOT"

if [[ -x "$ROOT/scripts/bootstrap-secrets.sh" ]]; then
    "$ROOT/scripts/bootstrap-secrets.sh"
else
    echo "  (bootstrap-secrets.sh not found — skipping)"
fi

echo "==> Directories -> ~/.config and \$HOME"
link_dir polybar              "$HOME/.config/polybar"
link_dir newsboat             "$HOME/.newsboat"
link_dir transmission-daemon  "$HOME/.config/transmission-daemon"
link_dir rofi                 "$HOME/.config/rofi"
link_dir urlscan              "$HOME/.config/urlscan"
link_dir urlview              "$HOME/.config/urlview"
link_dir surfraw              "$HOME/.config/surfraw"
link_dir ytfzf                "$HOME/.config/ytfzf"
link_dir .w3m                 "$HOME/.w3m"
link_dir ranger               "$HOME/.config/ranger"
link_dir mutt                 "$HOME/.config/mutt"
link_dir Kvantum              "$HOME/.config/Kvantum"
link_dir lf                   "$HOME/.config/lf"
link_dir mpv                  "$HOME/.config/mpv"
link_dir .mutt                "$HOME/.mutt"
link_dir dunst                "$HOME/.config/dunst"
link_dir alacritty            "$HOME/.config/alacritty"
link_dir nvim                 "$HOME/.config/nvim"
link_dir zsh                  "$HOME/.config/zsh"
link_dir conky                "$HOME/.config/conky"
link_dir bspwm                "$HOME/.config/bspwm"
link_dir sxhkd                "$HOME/.config/sxhkd"
link_dir qutebrowser          "$HOME/.config/qutebrowser"
link_dir zathura              "$HOME/.config/zathura"
link_dir mpd                  "$HOME/.config/mpd"
link_dir ncmpcpp              "$HOME/.config/ncmpcpp"
link_dir vivid                "$HOME/.config/vivid"
link_dir fish                 "$HOME/.config/fish"
link_dir imv                  "$HOME/.config/imv"
link_dir kitty                "$HOME/.config/kitty"
link_dir yazi                 "$HOME/.config/yazi"
link_dir fastfetch            "$HOME/.config/fastfetch"

echo "==> Files"
link_file mimeapps.list       "$HOME/.config/mimeapps.list"
link_file starship.toml       "$HOME/.config/starship.toml"
link_file twitchnotifier.cfg  "$HOME/.config/twitchnotifier.cfg"
link_file .bashrc             "$HOME/.bashrc"
link_file .bash_profile       "$HOME/.bash_profile"
link_file .Xresources         "$HOME/.Xresources"
link_file .tmux.conf          "$HOME/.tmux.conf"
link_file .Xmodmap            "$HOME/.Xmodmap"
link_file .profile            "$HOME/.profile"
link_file .zprofile           "$HOME/.zprofile"
link_file .inputrc            "$HOME/.inputrc"
link_file picom.conf          "$HOME/.config/picom.conf"
link_file .xprofile           "$HOME/.xprofile"
link_file .dir_colors         "$HOME/.dir_colors"
link_file .wgetrc             "$HOME/.wgetrc"

# .gitconfig is gitignored — link only if present (from bootstrap or manual copy)
if [[ -f "$ROOT/.gitconfig" ]]; then
    link_file .gitconfig "$HOME/.gitconfig"
else
    echo "  skip: .gitconfig (copy .gitconfig.example to .gitconfig if needed)"
fi

# zsh: repo also keeps a direct .zshrc symlink under ~/.config/zsh
if [[ -f "$ROOT/zsh/.zshrc" ]]; then
    link_file zsh/.zshrc "$HOME/.config/zsh/.zshrc"
fi

echo "==> Done"
echo "  Firefox: see docs/firefox.md (not managed by setup.sh)"
echo "  Optional: ./scripts/install-deps.sh  |  git config core.hooksPath .githooks"
