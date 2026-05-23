#!/usr/bin/env bash
# Random wallpaper cycler for X11 (xwallpaper) and Wayland (awww/swww).
set -euo pipefail

another_instance() {
    echo "There is another wallpaper cycler running (${BACKEND}, ${WAYLAND_DISPLAY:-x11}), exiting" >&2
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
    find "$1" -maxdepth 1 -type f \( \
        -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \
    \) | shuf -n 1
}

wayland_wallpaper_tool() {
    if command -v awww-daemon >/dev/null 2>&1; then
        echo awww
    elif command -v swww-daemon >/dev/null 2>&1; then
        echo swww
    fi
}

wayland_display_alive() {
    [[ -n "${WAYLAND_DISPLAY:-}" ]] || return 1
    [[ -S "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/${WAYLAND_DISPLAY}" ]]
}

detect_backend() {
    case "${WALLPAPER_BACKEND:-auto}" in
        wayland|x11) echo "$WALLPAPER_BACKEND" ;;
        auto)
            if wayland_display_alive && wayland_wallpaper_tool >/dev/null; then
                echo wayland
            else
                echo x11
            fi
            ;;
        *)
            echo "Unknown WALLPAPER_BACKEND: ${WALLPAPER_BACKEND}" >&2
            exit 1
            ;;
    esac
}

lock_file() {
    if [[ "$BACKEND" == wayland ]]; then
        echo "/tmp/$(basename "$0").wayland.${WAYLAND_DISPLAY:-default}.lock"
    else
        echo "/tmp/$(basename "$0").x11.lock"
    fi
}

awww_socket() {
    echo "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/${WAYLAND_DISPLAY}-awww-daemon.sock"
}

ensure_awww_daemon() {
    if awww query >/dev/null 2>&1; then
        return 0
    fi

    local sock
    sock=$(awww_socket)
    if [[ -S "$sock" ]]; then
        awww kill >/dev/null 2>&1 || rm -f "$sock"
        sleep 0.2
    fi

    awww-daemon &
    local i
    for i in 1 2 3 4 5 6 7 8 9 10; do
        awww query >/dev/null 2>&1 && return 0
        sleep 0.2
    done
    return 1
}

ensure_wayland_daemon() {
    local tool=$1

    if [[ "$tool" == awww ]]; then
        wayland_display_alive || return 1
        ensure_awww_daemon
        return
    fi

    if ! pgrep -x swww-daemon >/dev/null 2>&1; then
        swww-daemon &
        sleep 0.5
    fi
}

set_wallpaper() {
    local wall=$1

    if [[ "$BACKEND" == wayland ]]; then
        local tool
        tool=$(wayland_wallpaper_tool)
        ensure_wayland_daemon "$tool" || return 1
        if [[ "$tool" == awww ]]; then
            awww img "$wall" --resize crop
        else
            swww img "$wall" --fill
        fi
        return
    fi

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

BACKEND=$(detect_backend)
pidfile=$(lock_file)

exec 200>"$pidfile"
flock -n 200 || another_instance
echo "$$" >&200

dir="${1:-$(find_wall_dir || { echo "No wallpaper directory found" >&2; exit 1; })}"
time="${2:-1000}"

while true; do
    if [[ "$BACKEND" == wayland ]] && ! wayland_display_alive; then
        echo "Wayland display ${WAYLAND_DISPLAY:-?} gone, exiting" >&2
        exit 0
    fi

    wall=$(pick_wallpaper "$dir")
    if [[ -n "$wall" ]]; then
        set_wallpaper "$wall" || echo "wallpaper failed: $wall" >&2
    fi
    sleep "$time"
done
