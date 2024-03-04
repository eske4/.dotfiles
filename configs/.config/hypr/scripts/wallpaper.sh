#!/bin/bash

# Define log file location
log_file="$HOME/.cache/wal/log.txt"

# Check if colors.sh file exists
colors_file="$HOME/.cache/wal/colors.sh"
if [ ! -e "$colors_file" ]; then
    echo "Error: colors.sh file not found at $colors_file" >> "$log_file"
    wpg -s default.jpg
fi

if [[ ! -f "$HOME/.config/wpg/.current" ]]; then
    echo "File does not exist"
    wpg -s default.jpg
    
fi

sleep 0.1
swww img $(readlink -f $HOME/.config/wpg/.current) --transition-duration 4 --transition-step 2 --transition-fps 144 &
# Source colors.sh to load Pywal color scheme
source "$HOME/.cache/wal/colors.sh"
echo "Wallpaper: $colors_file" >> "$log_file"
pywalfox update &
pywal-discord -t default &
