#!/bin/bash

# Define log file location
log_file="$HOME/.cache/wal/log.txt"

# Check if colors.sh file exists
colors_file="$HOME/.cache/wal/colors.sh"
if [ ! -e "$colors_file" ]; then
    echo "Error: colors.sh file not found at $colors_file. Set default settings." >> "$log_file"
    wpg -s default.jpg
fi

# Check if .current file exists
current_file="$HOME/.config/wpg/.current"
if [[ ! -f "$current_file" ]]; then
    echo "Error: $current_file not found. Set default settings." >> "$log_file"
    wpg -s default.jpg
fi

# Apply wallpaper settings
sleep 0.1
swww img "$(readlink -f "$current_file")" --transition-duration 4 --transition-step 2 --transition-fps 144 &

# Source colors.sh to load Pywal color scheme
source "$colors_file"
echo "Wallpaper: $current_file" >> "$log_file"

# Update Pywalfox and Discord
pywalfox update &
pywal-discord -t default &
