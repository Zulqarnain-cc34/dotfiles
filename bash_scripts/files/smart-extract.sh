#!/bin/bash
# Extract one or more archives (passed as args, e.g. via yazi's %s).
#
# Each archive is checked for whether it already has a single top-level
# folder (the common "well-packaged" case). If so, it's extracted directly
# next to the archive -- no redundant wrapper folder. Otherwise it's
# extracted into a new folder named after the archive, auto-renamed on
# collision. Non-archive files in the selection are skipped, not fatal.
set -u

list_entries() {
    case "$1" in
        *.zip) unzip -Z1 "$1" 2>/dev/null ;;
        *.tar.bz2 | *.tar.gz | *.tar.xz | *.tar.zst | *.tgz | *.tar) tar tf "$1" 2>/dev/null ;;
        *.rar) unrar lb "$1" 2>/dev/null ;;
        *.7z)
            7z l -slt "$1" 2>/dev/null |
                awk '/^----------$/{f=1;next} f && /^Path = /{sub(/^Path = /,""); print}'
            ;;
    esac
}

is_single_rooted() {
    local f="$1" top ref="" first=1 entry
    while IFS= read -r entry; do
        [ -z "$entry" ] && continue
        case "$entry" in
            */*) top="${entry%%/*}" ;;
            *) return 1 ;; # a loose file at the root -> not single-rooted
        esac
        if [ "$first" = 1 ]; then
            ref="$top"
            first=0
        elif [ "$top" != "$ref" ]; then
            return 1
        fi
    done < <(list_entries "$f")
    [ "$first" = 0 ]
}

unique_dest() {
    local base="$1" dest="$1" i=1
    while [ -e "$dest" ]; do
        dest="$base-$i"
        i=$((i + 1))
    done
    printf '%s' "$dest"
}

for f in "$@"; do
    case "$f" in
        *.tar.bz2) base="${f%.tar.bz2}" ;;
        *.tar.gz) base="${f%.tar.gz}" ;;
        *.tar.xz) base="${f%.tar.xz}" ;;
        *.tar.zst) base="${f%.tar.zst}" ;;
        *.tgz) base="${f%.tgz}" ;;
        *.tar) base="${f%.tar}" ;;
        *.zip) base="${f%.zip}" ;;
        *.rar) base="${f%.rar}" ;;
        *.7z) base="${f%.7z}" ;;
        *.gz) base="${f%.gz}" ;;
        *.bz2) base="${f%.bz2}" ;;
        *.Z) base="${f%.Z}" ;;
        *.deb) base="${f%.deb}" ;;
        *) continue ;;
    esac
    dir=$(dirname "$f")
    base=$(basename "$base")

    case "$f" in
        # Real archives first, and explicitly, even though some of their
        # extensions (.tar.gz, .tar.bz2) would otherwise also match the
        # single-file-compressor patterns below (*.gz, *.bz2) -- case
        # matches top-to-bottom, first pattern wins, so order matters here.
        *.tar.bz2 | *.tar.gz | *.tar.xz | *.tar.zst | *.tgz | *.tar | *.zip | *.rar | *.7z)
            if is_single_rooted "$f"; then
                target="$dir"
            else
                target=$(unique_dest "$dir/$base")
                mkdir -p "$target"
            fi
            case "$f" in
                *.tar.bz2 | *.tar.gz | *.tar.xz | *.tar.zst | *.tgz | *.tar)
                    tar xf "$f" -C "$target"
                    ;;
                *.zip) unzip -o -q "$f" -d "$target" ;;
                *.rar) unrar x -y "$f" "$target/" ;;
                *.7z) 7z x "$f" -o"$target" -y ;;
            esac
            ;;
        # Single-file compressors: no archive structure, just decompress in place.
        *.gz) gzip -dc "$f" >"$dir/$base" ;;
        *.bz2) bzip2 -dc "$f" >"$dir/$base" ;;
        *.Z) uncompress -c "$f" >"$dir/$base" ;;
        # .deb has no single-root convention -- always wrap.
        *.deb)
            dest=$(unique_dest "$dir/$base")
            mkdir -p "$dest"
            (cd "$dest" && ar x "$f")
            ;;
    esac
done
