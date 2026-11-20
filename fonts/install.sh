#!/usr/bin/env bash
# Install the Nerd Fonts used across this repo's configs (kitty, fastfetch,
# rofi, polybar). The font files are NOT committed (the repo keeps no
# binaries; see scripts/validate.sh), so they are fetched from the official
# Nerd Fonts release on setup. setup.sh calls this, and you can also run it
# by hand. Each family only installs when missing; pass -f to force a
# reinstall of all of them.
set -euo pipefail

FORCE=0
[[ "${1:-}" == "-f" ]] && FORCE=1

install_font() {
    local family=$1 zip=$2 dest=$3
    shift 3
    local want=("$@")

    [[ "$FORCE" -eq 1 ]] && rm -rf "$dest"

    # Note: plain `grep -i ... >/dev/null`, not `grep -qi`. Under
    # `set -o pipefail`, grep -q exits on first match and SIGPIPEs fc-list,
    # so the pipeline returns non-zero even when the font IS present --
    # which would wrongly re-download it.
    if fc-list 2>/dev/null | grep -i "$family" >/dev/null; then
        echo "fonts: '$family' already installed"
        return 0
    fi

    local tmp="$(mktemp -d)"
    trap 'rm -rf "$tmp"' RETURN

    echo "fonts: downloading $family..."
    curl -fsSL -o "$tmp/$zip" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$zip"

    mkdir -p "$dest"
    unzip -o -j "$tmp/$zip" "${want[@]}" -d "$dest" >/dev/null
    echo "fonts: installed $family -> $dest"
}

for tool in curl unzip fc-cache; do
    command -v "$tool" >/dev/null || { echo "fonts: '$tool' is required" >&2; exit 1; }
done

# kitty, fastfetch
install_font "SauceCodePro Nerd Font" SourceCodePro.zip "$HOME/.local/share/fonts/SauceCodePro" \
    SauceCodeProNerdFont-Regular.ttf SauceCodeProNerdFont-Bold.ttf \
    SauceCodeProNerdFont-Italic.ttf SauceCodeProNerdFont-BoldItalic.ttf \
    SauceCodeProNerdFontMono-Regular.ttf SauceCodeProNerdFontMono-Bold.ttf \
    SauceCodeProNerdFontMono-Italic.ttf SauceCodeProNerdFontMono-BoldItalic.ttf

# rofi, polybar
install_font "Iosevka Nerd Font" Iosevka.zip "$HOME/.local/share/fonts/Iosevka" \
    IosevkaNerdFont-Regular.ttf IosevkaNerdFont-Bold.ttf \
    IosevkaNerdFont-Italic.ttf IosevkaNerdFont-BoldItalic.ttf \
    IosevkaNerdFontMono-Regular.ttf IosevkaNerdFontMono-Bold.ttf \
    IosevkaNerdFontMono-Italic.ttf IosevkaNerdFontMono-BoldItalic.ttf

# rofi ribbon launcher
# NOTE: the Nerd Fonts patcher abbreviates this family to "FantasqueSansM"
# (not "FantasqueSansMono") as of the current release -- the rofi configs
# reference "FantasqueSansM Nerd Font" to match. The plain (non-Propo,
# non-Mono) variant is the one that registers under that exact family name.
install_font "FantasqueSansM Nerd Font" FantasqueSansMono.zip "$HOME/.local/share/fonts/FantasqueSansMono" \
    FantasqueSansMNerdFont-Regular.ttf FantasqueSansMNerdFont-Bold.ttf \
    FantasqueSansMNerdFont-Italic.ttf FantasqueSansMNerdFont-BoldItalic.ttf

fc-cache -f "$HOME/.local/share/fonts" >/dev/null 2>&1
