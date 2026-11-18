#!/usr/bin/env bash
# Install the SauceCodePro Nerd Font (patched Source Code Pro) used by kitty and
# fastfetch. The font files are NOT committed (the repo keeps no binaries; see
# scripts/validate.sh), so they are fetched from the official Nerd Fonts release
# on setup. setup.sh calls this, and you can also run it by hand. It only installs
# when the family is missing; pass -f to force a reinstall.
set -euo pipefail

FAMILY="SauceCodePro Nerd Font"
DEST="$HOME/.local/share/fonts/SauceCodePro"
URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.zip"
WANT=(
    SauceCodeProNerdFont-Regular.ttf SauceCodeProNerdFont-Bold.ttf
    SauceCodeProNerdFont-Italic.ttf SauceCodeProNerdFont-BoldItalic.ttf
    SauceCodeProNerdFontMono-Regular.ttf SauceCodeProNerdFontMono-Bold.ttf
    SauceCodeProNerdFontMono-Italic.ttf SauceCodeProNerdFontMono-BoldItalic.ttf
)

[[ "${1:-}" == "-f" ]] && rm -rf "$DEST"

# Note: plain `grep -i ... >/dev/null`, not `grep -qi`. Under `set -o pipefail`,
# grep -q exits on first match and SIGPIPEs fc-list, so the pipeline returns
# non-zero even when the font IS present -- which would wrongly re-download it.
if fc-list 2>/dev/null | grep -i "$FAMILY" >/dev/null; then
    echo "fonts: '$FAMILY' already installed"
    exit 0
fi

for tool in curl unzip fc-cache; do
    command -v "$tool" >/dev/null || { echo "fonts: '$tool' is required to install $FAMILY" >&2; exit 1; }
done

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "fonts: downloading $FAMILY..."
curl -fsSL -o "$tmp/SourceCodePro.zip" "$URL"

mkdir -p "$DEST"
unzip -o -j "$tmp/SourceCodePro.zip" "${WANT[@]}" -d "$DEST" >/dev/null
fc-cache -f "$HOME/.local/share/fonts" >/dev/null 2>&1
echo "fonts: installed $FAMILY -> $DEST"
