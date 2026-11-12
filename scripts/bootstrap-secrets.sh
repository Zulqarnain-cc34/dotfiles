#!/usr/bin/env bash
# Create local-only files from templates (gitignored). Safe to run repeatedly.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ ! -f "$ROOT/.gitconfig" && -f "$ROOT/.gitconfig.example" ]]; then
    cp "$ROOT/.gitconfig.example" "$ROOT/.gitconfig"
    echo "  bootstrap: created .gitconfig from .gitconfig.example (edit name/email)"
fi

COLORS="$ROOT/rofi/launchers/ribbon/styles/colors.rasi"
EXAMPLE="$ROOT/rofi/launchers/ribbon/styles/colors.rasi.example"
if [[ ! -f "$COLORS" && -f "$EXAMPLE" ]]; then
    cp "$EXAMPLE" "$COLORS"
    echo "  bootstrap: created rofi ribbon colors.rasi from example"
fi

TRANSMISSION="$ROOT/transmission-daemon/settings.json"
TRANSMISSION_EXAMPLE="$ROOT/transmission-daemon/settings.json.example"
if [[ ! -f "$TRANSMISSION" && -f "$TRANSMISSION_EXAMPLE" ]]; then
    cp "$TRANSMISSION_EXAMPLE" "$TRANSMISSION"
    echo "  bootstrap: created transmission-daemon/settings.json from example"
    echo "    -> set a real rpc-password before starting transmission-daemon (it hashes it on first launch)"
fi
