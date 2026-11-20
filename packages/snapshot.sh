#!/usr/bin/env bash
# Capture a new numbered snapshot of every installed package (pacman, AUR,
# the combined total list, go, npm, pip) under packages/vN/, following the
# same six-file pattern as v2/v3. Not wired into setup.sh -- run by hand
# whenever you want a fresh snapshot to reproduce this system from later.
#
# Missing tools don't abort the whole capture -- each category is independent,
# so e.g. no go/npm/pip installed just means those three files are skipped.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

last=0
for d in "$ROOT"/v*/; do
    [[ -d "$d" ]] || continue
    n="$(basename "$d")"
    [[ "$n" =~ ^v([0-9]+)$ ]] || continue
    (( ${BASH_REMATCH[1]} > last )) && last=${BASH_REMATCH[1]}
done
next=$((last + 1))
dest="$ROOT/v$next"

if [[ -e "$dest" ]]; then
    echo "packages: $dest already exists, aborting" >&2
    exit 1
fi
mkdir -p "$dest"

SKIPPED=()

if command -v pacman >/dev/null; then
    pacman -Q | sort > "$dest/pacman-packages.txt"
    pacman -Qqm | sort > "$dest/yay-packages.txt"
    pacman -Qq | sort > "$dest/total-package-list.txt"
else
    echo "packages: pacman not found, skipping pacman/yay/total-package-list" >&2
    SKIPPED+=("pacman-packages.txt" "yay-packages.txt" "total-package-list.txt")
fi

if command -v go >/dev/null; then
    gobin="$(go env GOPATH 2>/dev/null)/bin"
    if [[ -d "$gobin" ]]; then
        ls "$gobin" | sort > "$dest/go-packages.txt"
    else
        echo "packages: $gobin doesn't exist, writing an empty go-packages.txt" >&2
        : > "$dest/go-packages.txt"
    fi
else
    echo "packages: go not found, skipping go-packages.txt" >&2
    SKIPPED+=("go-packages.txt")
fi

if command -v npm >/dev/null && command -v python3 >/dev/null; then
    npm list -g --depth=0 --json 2>/dev/null \
        | python3 -c "import json,sys; d=json.load(sys.stdin); print('\n'.join(sorted(d.get('dependencies',{}).keys())))" \
        > "$dest/npm-packages.txt"
else
    echo "packages: npm or python3 not found, skipping npm-packages.txt" >&2
    SKIPPED+=("npm-packages.txt")
fi

if command -v pip >/dev/null; then
    pip list > "$dest/pip-packages.txt"
else
    echo "packages: pip not found, skipping pip-packages.txt" >&2
    SKIPPED+=("pip-packages.txt")
fi

echo "packages: wrote $dest"
if ((${#SKIPPED[@]})); then
    echo "packages: skipped (tool not found): ${SKIPPED[*]}" >&2
fi
