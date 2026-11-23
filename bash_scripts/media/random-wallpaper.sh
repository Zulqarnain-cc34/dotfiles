#!/usr/bin/env bash
# Random wallpaper cycler for X11 (xwallpaper/feh, or GNOME via gsettings).
set -euo pipefail

another_instance() {
    echo "There is another wallpaper cycler running, exiting" >&2
    exit 1
}

find_wall_dir() {
    local d
    for d in "${WALLPAPER_DIR:-}" \
        "$HOME/Pictures/Wallpapers/Wallpapers" \
        "$HOME/Pictures/wallpapers" \
        "$HOME/Pictures/Wallpapers"; do
        [[ -n "$d" && -d "$d" ]] || continue
        if find "$d" -maxdepth 1 -type f \( \
            -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \
        \) -print -quit | grep -q .; then
            echo "$d"
            return 0
        fi
    done
    return 1
}

pick_wallpaper() {
    local dir=$1 exclude=${2:-}
    local -a files

    mapfile -t files < <(find "$dir" -maxdepth 1 -type f \( \
        -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \
    \))

    ((${#files[@]})) || return 1

    if [[ -n "$exclude" && ${#files[@]} -gt 1 ]]; then
        local -a filtered=()
        local f
        for f in "${files[@]}"; do
            [[ "$f" == "$exclude" ]] && continue
            filtered+=("$f")
        done
        ((${#filtered[@]})) && files=("${filtered[@]}")
    fi

    printf '%s\n' "${files[@]}" | shuf -n 1
}

set_wallpaper() {
    local wall=$1

    if [[ "${XDG_CURRENT_DESKTOP:-}" == GNOME ]]; then
        gsettings set org.gnome.desktop.background picture-uri "file://$wall"
    elif command -v xwallpaper >/dev/null 2>&1; then
        xwallpaper --stretch "$wall"
    elif command -v feh >/dev/null 2>&1; then
        feh --bg-fill "$wall"
    else
        echo "No X11 wallpaper tool found (xwallpaper/feh)" >&2
        exit 1
    fi
}

pidfile="/tmp/$(basename "$0").x11.lock"

# Read any existing holder's PID BEFORE opening fd 200 -- the `>` redirect
# truncates the file, so reading it afterwards always comes back empty (that was
# the bug that made kill+relogin fail: the PID to kill was already wiped).
old=$(cat "$pidfile" 2>/dev/null || true)   # || true: lock file is absent on a fresh boot; set -e must not bail here

exec 200>"$pidfile"
if ! flock -n 200; then
    # The lock is held, which means a previous cycler is still alive holding it
    # (killing bspwm orphans it as an init child). Take over: kill that holder, then
    # wait for the lock it releases. A dead holder would have released the lock
    # already, so reaching here means `old` is a live, valid PID.
    [[ "$old" =~ ^[0-9]+$ && "$old" != "$$" ]] && kill "$old" 2>/dev/null
    flock -w 3 200 || another_instance
fi
echo "$$" >&200

dir="${1:-$(find_wall_dir || { echo "No wallpaper directory found" >&2; exit 1; })}"
time="${2:-1000}"

last=""
while true; do
    wall=$(pick_wallpaper "$dir" "$last")
    if [[ -n "$wall" ]]; then
        set_wallpaper "$wall" || echo "wallpaper failed: $wall" >&2
        last="$wall"
    fi
    # Close fd 200 for this child specifically -- otherwise it inherits the
    # lock fd, and if the parent dies mid-sleep (e.g. `kill bspwm`), the sleep
    # process survives as an orphan still holding the lock open for up to
    # $time seconds, even though the actual cycler is long gone.
    sleep "$time" 200>&-
done
