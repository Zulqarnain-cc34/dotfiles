#!/usr/bin/env bash
# Print installed package counts as "N (pacman), M (yay)" for fastfetch.
#
# Splitting native (pacman -Qn) from foreign/AUR (pacman -Qm) needs a sync-db
# comparison (~0.3s each). Doing that at render time made fastfetch visibly
# stall and draw in two passes. So: print a cached value INSTANTLY and refresh
# it in the background (stale-while-revalidate). The total (pacman -Qq, local
# db only) is instant, so native = total - foreign; only the foreign count
# needs the one slow query.
cache="${XDG_CACHE_HOME:-$HOME/.cache}/fastfetch-pkgcount"

compute() {
    local total aur
    total=$(pacman -Qq 2>/dev/null | wc -l)
    aur=$(pacman -Qmq 2>/dev/null | wc -l)
    printf '%s (pacman), %s (yay)' "$(( total - aur ))" "$aur"
}

if [[ -s "$cache" ]]; then
    cat "$cache"
    # Refresh for next render without blocking this one. fds are detached from
    # the pipe fastfetch reads, so it sees EOF immediately (no stall).
    ( compute >"$cache.tmp" 2>/dev/null && mv "$cache.tmp" "$cache" ) </dev/null &>/dev/null &
else
    # First run: no cache yet -- compute synchronously, store, and print.
    compute | tee "$cache"
fi
