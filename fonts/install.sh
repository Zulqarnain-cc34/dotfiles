#!/usr/bin/env bash
# Install the Nerd Fonts used across this repo's configs (kitty, fastfetch,
# rofi, polybar). The font files are NOT committed (the repo keeps no
# binaries; see scripts/validate.sh), so they are fetched from the official
# Nerd Fonts release on setup. setup.sh calls this, and you can also run it
# by hand. Each family only installs when missing; pass -f to force a
# reinstall of all of them.
#
# No `set -e`: one family failing (network blip, upstream rename) must not
# stop the others from installing. Every failure path is handled explicitly
# below instead, and collected into a summary at the end.
set -uo pipefail

FORCE=0
[[ "${1:-}" == "-f" ]] && FORCE=1

FAILED=()

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

    local tmp
    tmp="$(mktemp -d)" || { echo "fonts: could not create a temp dir for $family" >&2; return 1; }

    echo "fonts: downloading $family..."
    if ! curl -fsSL --retry 3 --retry-delay 2 --retry-connrefused \
            -o "$tmp/$zip" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$zip"; then
        echo "fonts: download failed for $family" >&2
        rm -rf "$tmp"
        return 1
    fi

    # Catches a truncated/corrupt download before anything gets extracted
    # from it -- a partial file can still exit 0 from curl if the connection
    # merely stalled after headers were already sent.
    if ! unzip -tq "$tmp/$zip" >/dev/null 2>&1; then
        echo "fonts: downloaded archive for $family is corrupt, skipping" >&2
        rm -rf "$tmp"
        return 1
    fi

    # Extract to a staging dir first, not straight into $dest -- a half
    # extraction (e.g. upstream renamed one of the files we ask for) must
    # never leave $dest in a partially-populated, inconsistent state.
    local stage="$tmp/stage"
    mkdir -p "$stage"
    if ! unzip -o -j "$tmp/$zip" "${want[@]}" -d "$stage" >/dev/null 2>&1; then
        echo "fonts: one or more expected files missing from $zip for $family" >&2
        echo "fonts:   upstream may have renamed them -- check the release manually" >&2
        rm -rf "$tmp"
        return 1
    fi

    # unzip can exit 0 even when a requested member didn't match anything
    # (it just skips it), so confirm every file we asked for actually landed.
    local f
    for f in "${want[@]}"; do
        if [[ ! -s "$stage/$f" ]]; then
            echo "fonts: expected file missing after extraction for $family: $f" >&2
            rm -rf "$tmp"
            return 1
        fi
    done

    mkdir -p "$dest"
    mv -f "$stage"/* "$dest/"
    rm -rf "$tmp"
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
    SauceCodeProNerdFontMono-Italic.ttf SauceCodeProNerdFontMono-BoldItalic.ttf \
    || FAILED+=("SauceCodePro Nerd Font")

# rofi, polybar
install_font "Iosevka Nerd Font" Iosevka.zip "$HOME/.local/share/fonts/Iosevka" \
    IosevkaNerdFont-Regular.ttf IosevkaNerdFont-Bold.ttf \
    IosevkaNerdFont-Italic.ttf IosevkaNerdFont-BoldItalic.ttf \
    IosevkaNerdFontMono-Regular.ttf IosevkaNerdFontMono-Bold.ttf \
    IosevkaNerdFontMono-Italic.ttf IosevkaNerdFontMono-BoldItalic.ttf \
    || FAILED+=("Iosevka Nerd Font")

# rofi ribbon launcher
# NOTE: the Nerd Fonts patcher abbreviates this family to "FantasqueSansM"
# (not "FantasqueSansMono") as of the current release -- the rofi configs
# reference "FantasqueSansM Nerd Font" to match. The plain (non-Propo,
# non-Mono) variant is the one that registers under that exact family name.
install_font "FantasqueSansM Nerd Font" FantasqueSansMono.zip "$HOME/.local/share/fonts/FantasqueSansMono" \
    FantasqueSansMNerdFont-Regular.ttf FantasqueSansMNerdFont-Bold.ttf \
    FantasqueSansMNerdFont-Italic.ttf FantasqueSansMNerdFont-BoldItalic.ttf \
    || FAILED+=("FantasqueSansM Nerd Font")

# Always refresh the cache, even if some families above failed -- whatever
# did install successfully should still be usable immediately.
fc-cache -f "$HOME/.local/share/fonts" >/dev/null 2>&1

if ((${#FAILED[@]})); then
    echo "fonts: failed to install: ${FAILED[*]}" >&2
    exit 1
fi
