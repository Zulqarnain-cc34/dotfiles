#!/usr/bin/env bash
# Clear saved per-site page zoom. Close Firefox first.
set -euo pipefail

PROFILE="${1:-${HOME}/.mozilla/firefox/djekwmqv.default-release}"
DB="$PROFILE/content-prefs.sqlite"

if pgrep -x firefox >/dev/null 2>&1; then
    echo "Close Firefox first, then run this again." >&2
    exit 1
fi

[[ -f "$DB" ]] || { echo "No content-prefs.sqlite in $PROFILE" >&2; exit 1; }

sqlite3 "$DB" "DELETE FROM prefs WHERE name IN ('browser.content.full-zoom', 'browser.content.text-zoom');"
echo "Cleared per-site zoom in $DB"
