#!/usr/bin/env bash
# Random wallpaper on every niri workspace switch (including revisits).
set -uo pipefail

LOG="${HOME}/.cache/niri-workspace-wallpaper.log"
STATE="${HOME}/.cache/niri-workspace-wallpaper.state"
PICK="${HOME}/bin/bash_scripts/random-wallpaper.sh"
LOCK="${HOME}/.cache/niri-workspace-wallpaper.lock"

read_state() {
    last_focused=""
    last_wall=""
    [[ -f "$STATE" ]] || return 0
    IFS='|' read -r last_focused last_wall < "$STATE" || true
}

write_state() {
    printf '%s|%s\n' "$1" "$2" > "$STATE"
}

apply_random_wallpaper() {
    local id=$1 wall

    read_state
    wall=$("$PICK" --pick ${last_wall:+--exclude "$last_wall"}) || {
        echo "$(date -Iseconds) pick failed for workspace ${id}" >> "$LOG"
        return 1
    }
    WALLPAPER_BACKEND=wayland "$PICK" --set "$wall" || {
        echo "$(date -Iseconds) set failed for workspace ${id}: ${wall}" >> "$LOG"
        return 1
    }
    write_state "$id" "$wall"
    echo "$(date -Iseconds) workspace ${id}: ${wall}" >> "$LOG"
}

on_focused_workspace() {
    local id=$1

    [[ -n "$id" && "$id" != null ]] || return 0

    read_state
    [[ "$id" == "$last_focused" ]] && return 0

    apply_random_wallpaper "$id" || true
}

handle_workspace_activated() {
    local json=$1 id focused

    id=$(jq -r '.WorkspaceActivated.id' <<< "$json")
    focused=$(jq -r '.WorkspaceActivated.focused' <<< "$json")
    [[ "$focused" == "true" ]] || return 0
    on_focused_workspace "$id"
}

handle_workspaces_changed() {
    local json=$1 focused

    focused=$(jq -r '.WorkspacesChanged.workspaces[] | select(.is_focused == true) | .id' <<< "$json" | head -1)
    on_focused_workspace "$focused"
}

handle_event() {
    local line=$1

    jq -e . >/dev/null 2>&1 <<< "$line" || return 0

    if jq -e '.WorkspaceActivated' >/dev/null 2>&1 <<< "$line"; then
        handle_workspace_activated "$line"
    elif jq -e '.WorkspacesChanged' >/dev/null 2>&1 <<< "$line"; then
        handle_workspaces_changed "$line"
    fi
}

apply_initial() {
    local id

    id=$(niri msg --json workspaces | jq -r '.[] | select(.is_focused == true) | .id' | head -1)
    rm -f "$STATE"
    on_focused_workspace "$id"
}

stop_other_daemons() {
    local pid=$$
    while read -r line; do
        [[ "$line" =~ workspace-wallpaper\.sh\ daemon ]] || continue
        [[ "$line" =~ ^([0-9]+)\  ]] || continue
        [[ "${BASH_REMATCH[1]}" == "$pid" ]] && continue
        kill "${BASH_REMATCH[1]}" 2>/dev/null || true
    done < <(pgrep -af 'workspace-wallpaper\.sh daemon' 2>/dev/null || true)
}

run_event_loop() {
    while read -r line; do
        handle_event "$line" || echo "$(date -Iseconds) event failed: ${line:0:120}" >> "$LOG"
    done < <(niri msg --json event-stream)
}

run_daemon() {
    command -v niri jq awww >/dev/null 2>&1 || {
        echo "need niri, jq, and awww" >&2
        exit 1
    }

    [[ -n "${NIRI_SOCKET:-}" ]] || {
        echo "NIRI_SOCKET not set" >> "$LOG"
        exit 1
    }

    stop_other_daemons

    exec 200>"$LOCK"
    flock -n 200 || exit 0

    echo "$(date -Iseconds) daemon started (WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-?})" >> "$LOG"
    apply_initial

    while true; do
        run_event_loop || echo "$(date -Iseconds) event-stream ended, reconnecting" >> "$LOG"
        sleep 1
    done
}

case "${1:-daemon}" in
    daemon) run_daemon ;;
    apply)
        rm -f "$STATE"
        [[ -n "${2:-}" ]] || { echo "usage: $0 apply <workspace-id>" >&2; exit 1; }
        on_focused_workspace "$2"
        ;;
    *)
        echo "usage: $0 [daemon|apply <id>]" >&2
        exit 1
        ;;
esac
