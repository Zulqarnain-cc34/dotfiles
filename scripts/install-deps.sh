#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LIST="$ROOT/packages/minimal.txt"

if ! command -v pacman >/dev/null; then
    echo "pacman not found; install packages from $LIST manually." >&2
    exit 1
fi

mapfile -t pkgs < <(grep -v '^[[:space:]]*#' "$LIST" | grep -v '^[[:space:]]*$' || true)
echo "==> Installing ${#pkgs[@]} packages"
sudo pacman -S --needed --noconfirm "${pkgs[@]}"
