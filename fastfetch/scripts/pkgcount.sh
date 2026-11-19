#!/usr/bin/env bash
# Print installed package counts as "N (pacman), M (yay)" for fastfetch.
#
# pacman -Qm (foreign/AUR) is slow (~0.37s): it cross-references every
# installed package against every synced repo database, from scratch, on
# every call. The set of repo-known package names only actually changes on a
# real sync (pacman -Sy/-Syu) though -- far less often than individual
# installs -- so cache that list too, keyed to the sync db's own mtime. Once
# it exists, the foreign count becomes a local comparison (pacman -Qq + comm
# against the cached names), no more slow pacman -Qm calls at all, even for
# the background refresh below.
cache="${XDG_CACHE_HOME:-$HOME/.cache}/fastfetch-pkgcount"
names_cache="${XDG_CACHE_HOME:-$HOME/.cache}/fastfetch-pkgcount-reponames"
local_db=/var/lib/pacman/local
sync_db=/var/lib/pacman/sync

refresh_repo_names() {
    pacman -Slq 2>/dev/null | sort -u >| "$names_cache"
}

# Only safe to call once names_cache is confirmed fresh.
compute_fast() {
    local installed total aur
    installed=$(pacman -Qq 2>/dev/null | sort -u)
    total=$(wc -l <<< "$installed")
    aur=$(comm -23 <(printf '%s\n' "$installed") "$names_cache" | wc -l)
    printf '%s (pacman), %s (yay)' "$(( total - aur ))" "$aur" >| "$cache"
}

if [[ -s "$cache" ]]; then
    cat "$cache"
    if [[ "$local_db" -nt "$cache" ]]; then
        (
            [[ -s "$names_cache" && ! "$sync_db" -nt "$names_cache" ]] || refresh_repo_names
            compute_fast
        ) &
    fi
else
    # Bootstrap: need a synchronous answer right now. Plain pacman -Qm
    # (~0.37s) is faster than building the repo-names list from scratch
    # (~2.4s) would be, so use it once and build the fast-path cache in the
    # background for every call after this one.
    total=$(pacman -Qq 2>/dev/null | wc -l)
    aur=$(pacman -Qmq 2>/dev/null | wc -l)
    printf '%s (pacman), %s (yay)' "$(( total - aur ))" "$aur" >| "$cache"
    cat "$cache"
    ( [[ -s "$names_cache" ]] || refresh_repo_names ) &
fi
