#!/bin/bash

################################################################################
# Parallel Recursive Copy Script
# Usage: ./copy.sh <source_folder> <target_location>
# Example: ./copy.sh ./Booklets ~/program_files/Videos_mAin
#
# Creates: <target_location>/<source_folder_name>/ with all files and subfolders
################################################################################

set -uo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

RUN_ID="$$"
SUMMARY_FILE="/tmp/copy_summary_${RUN_ID}.txt"
: > "$SUMMARY_FILE"

error_exit() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
    rm -f "$SUMMARY_FILE"
    exit 1
}

success_msg() {
    echo -e "${GREEN}✅ $1${NC}"
}

info_msg() {
    echo -e "${YELLOW}ℹ️  $1${NC}"
}

if [[ $# -lt 2 ]]; then
    echo -e "${YELLOW}Usage: $0 <source_folder> <target_location>${NC}"
    echo ""
    echo "Examples:"
    echo "  $0 ./Booklets ~/program_files/Videos_mAin"
    echo "  $0 ~/Documents ~/backup"
    exit 1
fi

SOURCE_FOLDER="${1%/}"
TARGET_LOCATION="${2%/}"
SOURCE_FOLDER="${SOURCE_FOLDER/#\~/$HOME}"
TARGET_LOCATION="${TARGET_LOCATION/#\~/$HOME}"

if [[ ! -d "$SOURCE_FOLDER" ]]; then
    error_exit "Source folder does not exist: $SOURCE_FOLDER"
fi

if [[ ! -d "$TARGET_LOCATION" ]]; then
    info_msg "Creating target directory: $TARGET_LOCATION"
    mkdir -p "$TARGET_LOCATION" || error_exit "Failed to create target directory"
fi

if [[ ! -w "$TARGET_LOCATION" ]]; then
    error_exit "No write permission for target location: $TARGET_LOCATION"
fi

SOURCE_NAME="$(basename "$SOURCE_FOLDER")"
DEST_DIR="$TARGET_LOCATION/$SOURCE_NAME"
mkdir -p "$DEST_DIR" || error_exit "Failed to create destination: $DEST_DIR"

# rsync flags: -a archive, -v verbose, --partial resume over slow/fuse mounts
RSYNC_OPTS=(-av --partial --info=progress2)

info_msg "Starting copy from: $SOURCE_FOLDER"
info_msg "Target location: $DEST_DIR"
echo ""

mapfile -t folders < <(
    find "$SOURCE_FOLDER" -mindepth 1 -maxdepth 1 -type d -printf '%f\n'
)

root_file_count=$(
    find "$SOURCE_FOLDER" -mindepth 1 -maxdepth 1 -type f | wc -l
)

info_msg "Found ${#folders[@]} subfolder(s) and $root_file_count top-level file(s)"
echo ""

pids=()
job_names=()

run_rsync_job() {
    local label="$1"
    local src="$2"
    local dst="$3"
    shift 3
    local extra_opts=("$@")
    local slug
    slug="$(printf '%s' "$label" | tr -c '[:alnum:]._-' '_')"
    local log_file="/tmp/copy_${RUN_ID}_${slug}.log"

    (
        echo "[$(date '+%H:%M:%S')] Starting copy: $label"
        if rsync "${RSYNC_OPTS[@]}" "${extra_opts[@]}" "$src" "$dst" > "$log_file" 2>&1; then
            success_msg "[$label] Copy completed successfully"
            echo "SUCCESS:$label" >> "$SUMMARY_FILE"
        else
            echo -e "${RED}❌ [$label] Copy failed${NC}" >&2
            echo "FAILED:$label" >> "$SUMMARY_FILE"
            cat "$log_file" >&2
            exit 1
        fi
        rm -f "$log_file"
    ) &
    pids+=("$!")
    job_names+=("$label")
    echo "📦 Spawned copy process [PID: $!] for: $label"
}

# Copy top-level files only (old script skipped these entirely)
if (( root_file_count > 0 )); then
    run_rsync_job "top-level files" \
        "$SOURCE_FOLDER/" \
        "$DEST_DIR/" \
        --exclude='*/'
fi

# Copy each immediate subfolder in parallel (handles names with spaces)
for folder in "${folders[@]}"; do
    [[ -d "$SOURCE_FOLDER/$folder" ]] || continue
    run_rsync_job "$folder" \
        "$SOURCE_FOLDER/$folder/" \
        "$DEST_DIR/$folder/"
done

if [[ ${#pids[@]} -eq 0 ]]; then
    error_exit "Nothing to copy in: $SOURCE_FOLDER"
fi

echo ""
info_msg "All copy processes spawned. Waiting for completion..."
echo ""

failed_count=0
for pid in "${pids[@]}"; do
    if ! wait "$pid"; then
        ((failed_count++)) || true
    fi
done

success_count=$(grep -c "^SUCCESS:" "$SUMMARY_FILE" 2>/dev/null || echo 0)
failed_count=$(grep -c "^FAILED:" "$SUMMARY_FILE" 2>/dev/null || echo 0)

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info_msg "Copy operation completed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📊 Summary:"
success_msg "$success_count job(s) copied successfully"

if (( failed_count > 0 )); then
    echo -e "${RED}❌ $failed_count job(s) failed${NC}"
    echo ""
    echo "Failed:"
    grep "^FAILED:" "$SUMMARY_FILE" | cut -d':' -f2- | sed 's/^/  - /'
    rm -f "$SUMMARY_FILE"
    exit 1
fi

echo ""
info_msg "Source: $SOURCE_FOLDER"
info_msg "Target: $DEST_DIR"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

rm -f "$SUMMARY_FILE"
