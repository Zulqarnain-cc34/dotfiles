#!/bin/bash

################################################################################
# Parallel Recursive Copy Script
# Usage: ./copy.sh <source_folder> <target_location>
# Example: ./copy.sh /home/precision/etc /home/precision/mnt/usbstick/etc
################################################################################

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ============================================================================
# Function: Print error and exit
# ============================================================================
error_exit() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
    exit 1
}

# ============================================================================
# Function: Print success message
# ============================================================================
success_msg() {
    echo -e "${GREEN}✅ $1${NC}"
}

# ============================================================================
# Function: Print info message
# ============================================================================
info_msg() {
    echo -e "${YELLOW}ℹ️  $1${NC}"
}

# ============================================================================
# Argument Validation
# ============================================================================
if [[ $# -lt 2 ]]; then
    echo -e "${YELLOW}Usage: $0 <source_folder> <target_location>${NC}"
    echo ""
    echo "Examples:"
    echo "  $0 /home/precision/etc /home/precision/mnt/usbstick/etc"
    echo "  $0 ~/Documents ~/backup"
    echo "  $0 /var/log /mnt/backup/logs"
    exit 1
fi

# ============================================================================
# Configuration
# ============================================================================
SOURCE_FOLDER="${1%/}"  # Remove trailing slash if present
TARGET_LOCATION="${2%/}"

# Expand ~ to home directory
SOURCE_FOLDER="${SOURCE_FOLDER/#\~/$HOME}"
TARGET_LOCATION="${TARGET_LOCATION/#\~/$HOME}"

# ============================================================================
# Validation Checks
# ============================================================================

# Check if source folder exists
if [[ ! -d "$SOURCE_FOLDER" ]]; then
    error_exit "Source folder does not exist: $SOURCE_FOLDER"
fi

# Check if target location exists, create if not
if [[ ! -d "$TARGET_LOCATION" ]]; then
    info_msg "Creating target directory: $TARGET_LOCATION"
    mkdir -p "$TARGET_LOCATION" || error_exit "Failed to create target directory"
fi

# Check write permissions on target
if [[ ! -w "$TARGET_LOCATION" ]]; then
    error_exit "No write permission for target location: $TARGET_LOCATION"
fi

# ============================================================================
# Main Copy Logic
# ============================================================================

info_msg "Starting parallel copy from: $SOURCE_FOLDER"
info_msg "Target location: $TARGET_LOCATION"
echo ""

# Count total folders
total_folders=$(find "$SOURCE_FOLDER" -maxdepth 1 -type d ! -name "$(basename "$SOURCE_FOLDER")" | wc -l)
info_msg "Found $total_folders folder(s) to copy"
echo ""

# Initialize counters
copied=0
failed=0
pids=()  # Store background process IDs

# Get list of folders (only direct children, not recursive)
folders=($(find "$SOURCE_FOLDER" -maxdepth 1 -type d ! -name "$(basename "$SOURCE_FOLDER")" -printf '%f\n'))

# If no folders found, copy files directly
if [[ ${#folders[@]} -eq 0 ]]; then
    info_msg "No subdirectories found, copying contents of source folder..."
    rsync -av --progress "$SOURCE_FOLDER/" "$TARGET_LOCATION/" 2>&1 | grep -E "^(creating|[0-9]+%|\s+[0-9]+\s+[0-9]+%)" || true
    
    if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
        success_msg "Copy completed successfully"
    else
        error_exit "rsync failed for source folder"
    fi
    exit 0
fi

# ============================================================================
# Parallel Copy with Progress Tracking
# ============================================================================

for folder in "${folders[@]}"; do
    # Construct full paths
    source_path="$SOURCE_FOLDER/$folder"
    
    # Skip if not a directory
    if [[ ! -d "$source_path" ]]; then
        continue
    fi
    
    # Start rsync in background
    (
        echo "[$(date '+%H:%M:%S')] Starting copy: $folder"
        
        if rsync -av --progress "$source_path" "$TARGET_LOCATION/" > /tmp/copy_$$.log 2>&1; then
            success_msg "[$folder] Copy completed successfully"
            echo "SUCCESS:$folder" >> /tmp/copy_summary_$$.txt
        else
            echo -e "${RED}❌ [$folder] Copy failed${NC}" >&2
            echo "FAILED:$folder" >> /tmp/copy_summary_$$.txt
            cat /tmp/copy_$$.log >&2
        fi
        
        rm -f /tmp/copy_$$.log
    ) &
    
    # Store PID
    pids+=($!)
    
    echo "📦 Spawned copy process [PID: $!] for: $folder"
done

echo ""
info_msg "All copy processes spawned. Waiting for completion..."
echo ""

# ============================================================================
# Wait for All Background Processes
# ============================================================================

failed_count=0
for pid in "${pids[@]}"; do
    wait "$pid"
    if [[ $? -ne 0 ]]; then
        ((failed_count++))
    fi
done

# ============================================================================
# Summary Report
# ============================================================================

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info_msg "Copy operation completed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Parse summary
if [[ -f /tmp/copy_summary_$$.txt ]]; then
    success_count=$(grep -c "SUCCESS:" /tmp/copy_summary_$$.txt 2>/dev/null || echo 0)
    failed_count=$(grep -c "FAILED:" /tmp/copy_summary_$$.txt 2>/dev/null || echo 0)
    
    echo ""
    echo "📊 Summary:"
    success_msg "$success_count folder(s) copied successfully"
    
    if [[ $failed_count -gt 0 ]]; then
        echo -e "${RED}❌ $failed_count folder(s) failed${NC}"
        echo ""
        echo "Failed folders:"
        grep "FAILED:" /tmp/copy_summary_$$.txt | cut -d':' -f2 | sed 's/^/  - /'
    fi
    
    rm -f /tmp/copy_summary_$$.txt
else
    if [[ $failed_count -eq 0 ]]; then
        success_msg "All ${#folders[@]} folder(s) copied successfully"
    else
        echo -e "${RED}❌ $failed_count folder(s) failed${NC}"
        exit 1
    fi
fi

echo ""
info_msg "Source: $SOURCE_FOLDER"
info_msg "Target: $TARGET_LOCATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
