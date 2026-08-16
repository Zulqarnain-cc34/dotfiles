#!/bin/bash
#
# copy.sh — parallel file copy with rsync worker pool
#
# Usage:
#   copy.sh [-j N] <source_folder> <target_location>
#   COPY_JOBS=20 copy.sh ./Booklets ~/program_files/Videos_mAin
#
# Creates <target_location>/<source_name>/ mirroring all files from source.
# Runs up to N rsync jobs concurrently; starts new jobs as slots free up.

set -uo pipefail

readonly VERSION="2.0.0"
readonly DEFAULT_JOBS=20
readonly MIN_JOBS=1
readonly MAX_JOBS=64

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

RUN_ID="$$"
STATE_DIR=""
JOBS="$DEFAULT_JOBS"
SOURCE_FOLDER=""
TARGET_LOCATION=""
DEST_DIR=""
DRY_RUN=0
START_TS=0

# ── helpers ──────────────────────────────────────────────────────────────────

die() {
    echo -e "${RED}Error:${NC} $*" >&2
    cleanup_state
    exit 1
}

info()  { echo -e "${YELLOW}ℹ${NC}  $*"; }
ok()    { echo -e "${GREEN}✓${NC}  $*"; }

usage() {
    cat <<EOF
${BOLD}copy.sh${NC} v${VERSION} — parallel rsync copy with worker pool

${BOLD}Usage:${NC}
  $0 [-j N] [-n] <source_folder> <target_location>

${BOLD}Options:${NC}
  -j, --jobs N   Max concurrent rsync workers (default: ${DEFAULT_JOBS}, max: ${MAX_JOBS})
  -n, --dry-run  List work items without copying
  -h, --help     Show this help

${BOLD}Environment:${NC}
  COPY_JOBS      Same as -j

${BOLD}Example:${NC}
  $0 -j 20 ./Booklets ~/program_files/Videos_mAin
EOF
}

cleanup_state() {
    [[ -n "$STATE_DIR" && -d "$STATE_DIR" ]] || return 0
    rm -rf "$STATE_DIR"
}

trap 'echo; die "Interrupted — stopping workers"; kill $(jobs -p) 2>/dev/null; wait 2>/dev/null; exit 130' INT TERM

init_state() {
    STATE_DIR=$(mktemp -d "/tmp/copy_${RUN_ID}.XXXXXX") || die "Failed to create state directory"
    : > "$STATE_DIR/done.list"
    : > "$STATE_DIR/failed.list"
    : > "$STATE_DIR/active.list"
    echo 0 > "$STATE_DIR/done.count"
    echo 0 > "$STATE_DIR/failed.count"
    echo 0 > "$STATE_DIR/bytes.count"
}

state_inc() {
    local file="$1"
    local lock="$STATE_DIR/.lock"
    { flock -x 200
      local n
      n=$(< "$file")
      echo $((n + 1)) > "$file"
    } 200>"$lock"
}

state_add_bytes() {
    local delta="$1"
    [[ "$delta" =~ ^[0-9]+$ ]] || return 0
    local lock="$STATE_DIR/.lock"
    { flock -x 200
      local n
      n=$(< "$STATE_DIR/bytes.count")
      echo $((n + delta)) > "$STATE_DIR/bytes.count"
    } 200>"$lock"
}

human_bytes() {
    awk -v b="${1:-0}" 'BEGIN {
        if (b >= 1073741824) printf "%.2f GiB", b/1073741824
        else if (b >= 1048576) printf "%.2f MiB", b/1048576
        else if (b >= 1024) printf "%.2f KiB", b/1024
        else printf "%d B", b
    }'
}

fmt_duration() {
    local s="$1"
    (( s < 60 )) && { printf '%ds' "$s"; return; }
    (( s < 3600 )) && { printf '%dm %ds' $((s/60)) $((s%60)); return; }
    printf '%dh %dm' $((s/3600)) $(((s%3600)/60))
}

draw_bar() {
    local pct="$1" width="${2:-30}"
    local filled=$(( pct * width / 100 ))
    local empty=$(( width - filled ))
    printf '%*s' "$filled" '' | tr ' ' '█'
    printf '%*s' "$empty" '' | tr ' ' '░'
}

# ── argument parsing ─────────────────────────────────────────────────────────

parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -j|--jobs)
                [[ $# -ge 2 ]] || die "Option $1 requires a number"
                JOBS="$2"
                shift 2
                ;;
            -n|--dry-run)
                DRY_RUN=1
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            --)
                shift
                break
                ;;
            -*)
                die "Unknown option: $1 (use --help)"
                ;;
            *)
                break
                ;;
        esac
    done

    [[ $# -eq 2 ]] || { usage; exit 1; }

    SOURCE_FOLDER="${1%/}"
    TARGET_LOCATION="${2%/}"
    SOURCE_FOLDER="${SOURCE_FOLDER/#\~/$HOME}"
    TARGET_LOCATION="${TARGET_LOCATION/#\~/$HOME}"

    [[ -n "${COPY_JOBS:-}" ]] && JOBS="$COPY_JOBS"
    [[ "$JOBS" =~ ^[0-9]+$ ]] || die "Jobs must be a number, got: $JOBS"
    (( JOBS >= MIN_JOBS && JOBS <= MAX_JOBS )) || die "Jobs must be between ${MIN_JOBS} and ${MAX_JOBS}"
}

validate_paths() {
    [[ -d "$SOURCE_FOLDER" ]] || die "Source folder does not exist: $SOURCE_FOLDER"

    if [[ ! -d "$TARGET_LOCATION" ]]; then
        info "Creating target directory: $TARGET_LOCATION"
        mkdir -p "$TARGET_LOCATION" || die "Cannot create: $TARGET_LOCATION"
    fi

    [[ -w "$TARGET_LOCATION" ]] || die "No write permission: $TARGET_LOCATION"

    local src_name
    src_name=$(basename "$SOURCE_FOLDER")
    DEST_DIR="$TARGET_LOCATION/$src_name"
    mkdir -p "$DEST_DIR" || die "Cannot create: $DEST_DIR"
}

# ── work queue ───────────────────────────────────────────────────────────────
# Each queue item: rel_path|src_abs|dst_abs|size_bytes

declare -a QUEUE=()

build_queue() {
    local src_root="$1" dst_root="$2"
    local rel src dst size

    while IFS= read -r -d '' src; do
        rel="${src#"$src_root"/}"
        dst="$dst_root/$rel"
        size=$(stat -c '%s' "$src" 2>/dev/null || echo 0)
        QUEUE+=("${rel}|${src}|${dst}|${size}")
    done < <(find "$src_root" -type f -print0)

    # Preserve empty directories
    while IFS= read -r -d '' src; do
        rel="${src#"$src_root"/}"
        dst="$dst_root/$rel"
        [[ -d "$dst" ]] && continue
        QUEUE+=("${rel}/|${src}|${dst}|0")
    done < <(find "$src_root" -type d ! -path "$src_root" -empty -print0)
}

queue_total_bytes() {
    local total=0 item size
    for item in "${QUEUE[@]}"; do
        size="${item##*|}"
        total=$((total + size))
    done
    echo "$total"
}

# ── rsync worker ─────────────────────────────────────────────────────────────

run_copy_job() {
    local rel="$1" src="$2" dst="$3" size="$4"
    local log="$STATE_DIR/logs/${rel//\//__}"
    local -a rsync_opts

    mkdir -p "$STATE_DIR/logs" "$(dirname "$dst")"

    rsync_opts=(
        -a
        --partial
        --partial-dir=.rsync-partial
        --info=stats2
        --human-readable
    )

    if [[ "$size" -eq 0 && "$rel" == */ ]]; then
        mkdir -p "$dst"
        echo "OK:$rel" >> "$STATE_DIR/done.list"
        state_inc "$STATE_DIR/done.count"
        return 0
    fi

    if rsync "${rsync_opts[@]}" -- "$src" "$dst" > "$log" 2>&1; then
        echo "OK:$rel" >> "$STATE_DIR/done.list"
        state_inc "$STATE_DIR/done.count"
        state_add_bytes "$size"
        rm -f "$log"
        return 0
    fi

    echo "FAIL:$rel" >> "$STATE_DIR/failed.list"
    state_inc "$STATE_DIR/failed.count"
    echo "$rel" >> "$STATE_DIR/failed.names"
    cp "$log" "$STATE_DIR/logs/FAILED_${rel//\//__}.log" 2>/dev/null || true
    return 1
}

# ── progress display ─────────────────────────────────────────────────────────

render_progress() {
    local total="$1" done failed active last elapsed total_bytes copied_bytes
    done=$(< "$STATE_DIR/done.count")
    failed=$(< "$STATE_DIR/failed.count")
    active=$(jobs -rp 2>/dev/null | wc -l)
    elapsed=$(($(date +%s) - START_TS))
    total_bytes="$2"
    copied_bytes=$(< "$STATE_DIR/bytes.count")

    last=""
    if [[ -f "$STATE_DIR/done.list" ]]; then
        last=$(tail -1 "$STATE_DIR/done.list" 2>/dev/null | sed 's/^OK://')
    fi

    local pct=0
    (( total > 0 )) && pct=$(( (done + failed) * 100 / total ))

    local eta_str="—"
    local completed=$((done + failed))
    if (( completed > 0 && completed < total )); then
        local rate=$((elapsed / completed))
        local remain=$(( (total - completed) * rate ))
        eta_str=$(fmt_duration "$remain")
    elif (( completed >= total && total > 0 )); then
        eta_str="done"
    fi

    local byte_pct=0
    (( total_bytes > 0 )) && byte_pct=$(( copied_bytes * 100 / total_bytes ))

    printf '\033[2J\033[H'   # clear screen
    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD} copy.sh${NC}  parallel rsync  ${DIM}(workers: ${JOBS})${NC}"
    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e " ${CYAN}Source${NC}  $SOURCE_FOLDER"
    echo -e " ${CYAN}Target${NC}  $DEST_DIR"
    echo ""
    echo -e " ${BOLD}Files${NC}    $(draw_bar "$pct")  ${done}/${total} (${pct}%)"
    echo -e " ${BOLD}Data${NC}     $(draw_bar "$byte_pct")  $(human_bytes "$copied_bytes") / $(human_bytes "$total_bytes")"
    echo ""
    echo -e " ${BOLD}Active${NC}   ${active} running   ${DIM}(max ${JOBS})${NC}"
    echo -e " ${BOLD}Done${NC}     ${GREEN}${done} ok${NC}   ${RED}${failed} failed${NC}"
    echo -e " ${BOLD}Elapsed${NC}  $(fmt_duration "$elapsed")   ${BOLD}ETA${NC}  ${eta_str}"
    [[ -n "$last" ]] && echo -e " ${BOLD}Last${NC}     ${DIM}${last}${NC}"
    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# ── worker pool ──────────────────────────────────────────────────────────────

run_pool() {
    local total="${#QUEUE[@]}"
    local total_bytes="$1"
    local idx=0 running=0
    declare -A pid_map=()

    START_TS=$(date +%s)

    while (( idx < total || running > 0 )); do
        # Fill open slots
        while (( running < JOBS && idx < total )); do
            IFS='|' read -r rel src dst size <<< "${QUEUE[idx]}"
            (
                run_copy_job "$rel" "$src" "$dst" "$size"
            ) &
            pid_map[$!]="$rel"
            ((idx++))
            ((running++))
        done

        # Reap finished workers
        local -a finished_pids=()
        for pid in "${!pid_map[@]}"; do
            if ! kill -0 "$pid" 2>/dev/null; then
                finished_pids+=("$pid")
            fi
        done
        for pid in "${finished_pids[@]}"; do
            wait "$pid" 2>/dev/null || true
            unset 'pid_map[$pid]'
            ((running--))
        done

        render_progress "$total" "$total_bytes"
        sleep 0.4
    done

    echo ""
}

print_summary() {
    local total="${#QUEUE[@]}"
    local done failed elapsed total_bytes copied_bytes
    done=$(< "$STATE_DIR/done.count")
    failed=$(< "$STATE_DIR/failed.count")
    elapsed=$(($(date +%s) - START_TS))
    total_bytes=$(queue_total_bytes)
    copied_bytes=$(< "$STATE_DIR/bytes.count")

    echo ""
    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD} Summary${NC}"
    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    ok "${done}/${total} items copied"
    echo -e "   Data transferred: $(human_bytes "$copied_bytes") / $(human_bytes "$total_bytes")"
    echo -e "   Duration:         $(fmt_duration "$elapsed")"
    echo -e "   Destination:      $DEST_DIR"

    if (( failed > 0 )); then
        echo -e " ${RED}✗${NC}  ${failed} item(s) failed:"
        if [[ -f "$STATE_DIR/failed.names" ]]; then
            sed 's/^/     - /' "$STATE_DIR/failed.names"
        fi
        echo -e "   Logs: $STATE_DIR/logs/"
        echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        return 1
    fi

    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    return 0
}

# ── main ─────────────────────────────────────────────────────────────────────

main() {
    parse_args "$@"
    validate_paths
    build_queue "$SOURCE_FOLDER" "$DEST_DIR"

    ((${#QUEUE[@]} > 0)) || die "No files or directories to copy in: $SOURCE_FOLDER"

    local total_bytes
    total_bytes=$(queue_total_bytes)

    info "Queued ${#QUEUE[@]} item(s), $(human_bytes "$total_bytes") total"
    info "Workers: ${JOBS} concurrent rsync jobs"
    info "Destination: $DEST_DIR"
    echo ""

    if (( DRY_RUN )); then
        printf '%s\n' "${QUEUE[@]}" | while IFS='|' read -r rel src dst size; do
            printf '  %-60s  %s\n' "$rel" "$(human_bytes "$size")"
        done
        exit 0
    fi

    init_state
    run_pool "$total_bytes"
    print_summary
    local rc=$?
    cleanup_state
    exit "$rc"
}

main "$@"
