#!/usr/bin/env bash
# Print installed package counts as "N (pacman), M (yay)" for fastfetch.
#
# Splitting native (pacman -Qn) from foreign/AUR (pacman -Qm) needs a sync-db
# comparison (~0.3s), too slow to run on every render. So cache the result and
# only recompute when it is STALE -- i.e. when the pacman local db changed since
# the cache was written (a package was installed, removed, or upgraded). Normal
# renders just cat the cache (instant); the one recompute lands right after a
# pacman transaction, which is exactly when the count actually changed.
cache="${XDG_CACHE_HOME:-$HOME/.cache}/fastfetch-pkgcount"
db=/var/lib/pacman/local

compute() {
    local total aur
    total=$(pacman -Qq 2>/dev/null | wc -l)
    aur=$(pacman -Qmq 2>/dev/null | wc -l)
    printf '%s (pacman), %s (yay)' "$(( total - aur ))" "$aur"
}

# Serve the cache only while it is fresh: it must be non-empty AND the pacman db
# must not be newer than it. Otherwise the cache is stale -> recompute + rewrite.
if [[ -s "$cache" && ! "$db" -nt "$cache" ]]; then
    cat "$cache"
else
    compute | tee "$cache"
fi
