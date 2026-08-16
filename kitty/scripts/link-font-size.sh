#!/usr/bin/env bash
# Point ~/.config/kitty/font_size.conf at the right snippet for this session.
set -euo pipefail

KITTY_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kitty"

detect_bspwm() {
    if pgrep -x bspwm >/dev/null 2>&1; then
        return 0
    fi
    case ":${DESKTOP_SESSION:-}:${XDG_CURRENT_DESKTOP:-}:${XDG_SESSION_DESKTOP:-}:" in
        *:bspwm:*|*:BSPWM:*) return 0 ;;
    esac
    return 1
}

if detect_bspwm; then
    target="font_size-bspwm.conf"
else
    target="font_size-default.conf"
fi

[[ -d "$KITTY_DIR" ]] || exit 0
[[ -f "$KITTY_DIR/$target" ]] || { echo "Missing $KITTY_DIR/$target" >&2; exit 1; }

ln -sf "$target" "$KITTY_DIR/font_size.conf"
