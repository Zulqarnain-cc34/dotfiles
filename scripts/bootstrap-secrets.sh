#!/usr/bin/env bash
# Create optional local files from *.example (only if missing).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

install_if_missing() {
    local src=$1 dest=$2
    if [[ ! -e "$dest" ]]; then
        mkdir -p "$(dirname "$dest")"
        cp "$src" "$dest"
        echo "  created: $dest (from $(basename "$src"))"
    else
        echo "  exists:  $dest"
    fi
}

echo "==> Bootstrapping optional local configs"

if [[ -f "$ROOT/.gitconfig.example" ]]; then
    install_if_missing "$ROOT/.gitconfig.example" "$ROOT/.gitconfig"
else
    echo "  skip:    .gitconfig.example not found"
fi

echo "==> Done."
