#!/usr/bin/env bash
# Symlink dotfiles user.js into the active Firefox profile.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/firefox-sweet-theme/configuration/user.js"
INI="${HOME}/.mozilla/firefox/profiles.ini"

[[ -f "$SRC" ]] || { echo "Missing $SRC" >&2; exit 1; }

profile_path() {
    local path=""
    if [[ -f "$INI" ]]; then
        path=$(awk -F= '
            /^\[Install/ { in_install=1; next }
            in_install && /^Default=/ { gsub(/^[ \t]+|[ \t\r]+$/, "", $2); print $2; exit }
        ' "$INI")
    fi
    if [[ -z "$path" && -f "$INI" ]]; then
        path=$(awk -F= '
            /^\[Profile0\]/ { in0=1; next }
            in0 && /^Path=/ { gsub(/^[ \t]+|[ \t\r]+$/, "", $2); print $2; exit }
        ' "$INI")
    fi
    [[ -n "$path" ]] || return 1
    echo "${HOME}/.mozilla/firefox/${path}"
}

if [[ -n "${1:-}" ]]; then
    DEST="$1"
else
    DEST=$(profile_path || true)
fi

[[ -n "${DEST:-}" && -d "$DEST" ]] || {
    echo "Could not find Firefox profile under ~/.mozilla/firefox/" >&2
    exit 1
}

ln -sfn "$SRC" "$DEST/user.js"
echo "Linked $DEST/user.js -> $SRC"
echo "Restart Firefox for zoom prefs to apply."
