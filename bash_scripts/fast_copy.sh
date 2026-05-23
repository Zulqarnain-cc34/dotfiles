#!/bin/bash

# --- CONFIGURATION ---
# The folder where your USB is mounted (Leave the trailing slash!)
# SOURCE="/home/alpha/LAN/" 
#
# # The local folder on your drive where you want the files to go
# # Change this to your actual destination path
# DESTINATION="/home/alpha/my_backup/" 
# # ---------------------
#
# 1. Create destination directory if it doesn't exist
mkdir -p "$DESTINATION"

# 2. Check if rsync is installed (since you are on archiso, it might not be)
if ! command -v rsync &> /dev/null; then
    echo "rsync is not installed. Installing it now for maximum speed..."
    sudo pacman -Sy rsync --noconfirm
fi

echo "=========================================="
#!/bin/bash

# 1. Check if the user provided exactly 2 arguments
if [ "$#" -ne 2 ]; then
    echo "Error: Missing arguments."
    echo "Usage: $0 <source_folder> <destination_folder>"
    echo "Example: $0 /home/alpha/LAN/ /home/alpha/my_backup/"
    exit 1
fi

# Assign arguments to variables
SOURCE="$1"
DESTINATION="$2"

# 2. Check if the source directory actually exists
if [ ! -d "$SOURCE" ]; then
    echo "Error: The source directory '$SOURCE' does not exist!"
    exit 1
fi

# 3. Create destination directory if it doesn't exist
mkdir -p "$DESTINATION"

# 4. Check if rsync is installed
if ! command -v rsync &> /dev/null; then
    echo "rsync is not installed. Installing it now for maximum speed..."
    sudo pacman -Sy rsync --noconfirm
fi

echo "=========================================="
echo " Starting Fast Copy..."
echo " Source: $SOURCE"
echo " Target: $DESTINATION"
echo "=========================================="

# Start a timer
start_time=$(date +%s)

# 5. The high-speed copy command
rsync -ahW --info=progress2 "$SOURCE" "$DESTINATION"

# Calculate time taken
end_time=$(date +%s)
duration=$((end_time - start_time))

echo ""
echo "=========================================="
echo " Copy finished successfully in $duration seconds!"
echo "=========================================="
