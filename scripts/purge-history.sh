#!/usr/bin/env bash
# Remove sensitive paths from entire git history (git-filter-repo).
# Usage: ./scripts/purge-history.sh --dry-run | --execute
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PATHS=(
    polybar/gmail
    polybar/scripts/gmail
    .w3m/cookie
    .w3m/history
)

DRY_RUN=true
for arg in "$@"; do
    case "$arg" in
        --dry-run)  DRY_RUN=true ;;
        --execute)  DRY_RUN=false ;;
        -h|--help)
            echo "Usage: $0 --dry-run | --execute"
            echo "Removes from all history:"
            printf '  - %s\n' "${PATHS[@]}"
            echo "After --execute: git push --force-with-lease ssh main"
            exit 0
            ;;
        *) echo "Unknown option: $arg" >&2; exit 1 ;;
    esac
done

if ! command -v git-filter-repo >/dev/null; then
    echo "Install: pacman -S git-filter-repo" >&2
    exit 1
fi

# Each path needs its own --path flag (not one --path with multiple args).
filter_args=(--invert-paths)
for p in "${PATHS[@]}"; do
    filter_args+=(--path "$p")
done

if $DRY_RUN; then
    echo "==> Dry run (no changes)"
    git filter-repo "${filter_args[@]}" --dry-run
    echo "Run with --execute to rewrite history."
else
    echo "==> Rewriting history — backup clone recommended"
    read -r -p "Type YES to continue: " confirm
    [[ "$confirm" == YES ]] || { echo "Aborted."; exit 1; }
    git filter-repo "${filter_args[@]}" --force
    echo "==> Done. Verify: ./scripts/validate.sh --history"
    echo "    Then: git push --force-with-lease ssh main"
fi
