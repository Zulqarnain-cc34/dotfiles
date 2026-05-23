#!/usr/bin/env bash
# Per-workspace wallpapers for niri (dynamic workspaces).
# Assigns a random image when a workspace first appears; applies it on focus.
set -euo pipefail

MAP="${HOME}/.cache/niri-workspace-wallpapers.map"
LOG="${HOME}/.cache/niri-workspace-wallpaper.log"
PICK="${HOME}/bin/bash_scripts/random-wallpaper.sh"
LOCK="${HOME}/.cache/niri-workspace-wallpaper.lock"

ensure_map() {
    mkdir -p "$(dirname "$MAP")"
    touch "$MAP"
}

assign_workspace() {
    local id=$1 wall

    ensure_map
    if grep -q "^${id}=" "$MAP" 2>/dev/null; then
        return 0
    fi

    wall=$("$PICK" --pick) || return 1
    echo "${id}=${wall}" >> "$MAP"
    echo "$(date -Iseconds) assigned workspace ${id}: ${wall}" >> "$LOG"
}

apply_workspace() {
    local id=$1 wall

    ensure_map
    assign_workspace "$id"

    wall=$(grep "^${id}=" "$MAP" | tail -1 | cut -d= -f2-)
    [[ -n "$wall" && -f "$wall" ]] || return 1

    WALLPAPER_BACKEND=wayland "$PICK" --set "$wall"
    echo "$(date -Iseconds) applied workspace ${id}: ${wall}" >> "$LOG"
}

handle_workspaces_changed() {
    local json=$1 id focused

    while read -r id; do
        [[ -n "$id" && "$id" != null ]] || continue
        assign_workspace "$id"
    done < <(jq -r '.WorkspacesChanged.workspaces[].id' <<< "$json")

    focused=$(jq -r '.WorkspacesChanged.workspaces[] | select(.is_focused == true) | .id' <<< "$json" | head -1)
    if [[ -n "$focused" && "$focused" != null ]]; then
        apply_workspace "$focused"
    fi
}

handle_workspace_activated() {
    local json=$1 id focused

    id=$(jq -r '.WorkspaceActivated.id' <<< "$json")
    focused=$(jq -r '.WorkspaceActivated.focused' <<< "$json")
    [[ "$focused" == "true" && -n "$id" && "$id" != null ]] || return 0
    apply_workspace "$id"
}

handle_event() {
    local line=$1

    jq -e . >/dev/null 2>&1 <<< "$line" || return 0

    if jq -e '.WorkspacesChanged' >/dev/null 2>&1 <<< "$line"; then
        handle_workspaces_changed "$line"
    elif jq -e '.WorkspaceActivated' >/dev/null 2>&1 <<< "$line"; then
        handle_workspace_activated "$line"
    fi
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

    exec 200>"$LOCK"
    flock -n 200 || exit 0

    : > "$LOG"
    echo "$(date -Iseconds) daemon started (WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-?})" >> "$LOG"

    niri msg --json event-stream | while read -r line; do
        handle_event "$line" || echo "$(date -Iseconds) event failed: ${line:0:120}" >> "$LOG"
    done
}

case "${1:-daemon}" in
    daemon) run_daemon ;;
    apply)
        [[ -n "${2:-}" ]] || { echo "usage: $0 apply <workspace-id>" >&2; exit 1; }
        apply_workspace "$2"
        ;;
    assign)
        [[ -n "${2:-}" ]] || { echo "usage: $0 assign <workspace-id>" >&2; exit 1; }
        assign_workspace "$2"
        ;;
    *)
        echo "usage: $0 [daemon|apply <id>|assign <id>]" >&2
        exit 1
        ;;
esac
