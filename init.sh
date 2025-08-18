# Source aliases and functions
# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source files in the aliases directory
for file in "$SCRIPT_DIR/aliases"/*.sh; do
    if [ -f "$file" ]; then
        source "$file"
        echo "Loaded $file"
    fi
done
