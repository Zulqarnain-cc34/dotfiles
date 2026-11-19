#!/usr/bin/env bash
# Print installed package counts as "N (pacman), M (yay)" for fastfetch.
#
# Splitting native (pacman -Qn) from foreign/AUR (pacman -Qm) needs a sync-db
# comparison (~0.35s) -- too slow to ever block a render on. So always print
# whatever is cached immediately, even if it's one pacman transaction stale,
# and refresh the cache in the background for next time. Only the very first
# run ever (no cache file at all) has to compute synchronously once.
cache="${XDG_CACHE_HOME:-$HOME/.cache}/fastfetch-pkgcount"
db=/var/lib/pacman/local

compute_and_cache() {
    local total aur
    total=$(pacman -Qq 2>/dev/null | wc -l)
    aur=$(pacman -Qmq 2>/dev/null | wc -l)
    printf '%s (pacman), %s (yay)' "$(( total - aur ))" "$aur" >| "$cache"
}

if [[ -s "$cache" ]]; then
    cat "$cache"
    [[ "$db" -nt "$cache" ]] && (compute_and_cache &) 2>/dev/null
else
    compute_and_cache
    cat "$cache"
fi
