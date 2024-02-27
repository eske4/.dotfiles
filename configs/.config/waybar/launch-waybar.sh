#!/bin/bash

TEMP_FILE=/tmp/waybarSpamPreventer

# Check if the preventer file already exists
if [ -f "$TEMP_FILE" ]; then
    echo "Script is already running or has not completed successfully."
    exit 1
fi

# Create the preventer file
touch "$TEMP_FILE"

# Your main script logic goes here
killall waybar

# Wait until waybar is no longer running
while pgrep -x waybar > /dev/null; do
    sleep 0.1
done

# Copy colors configuration
cp "$HOME/.cache/wal/colors-waybar.css" "$HOME/.dotfiles/configs/.config/waybar/themes/colors-import.css"

# Start waybar
waybar -c "$HOME/.config/waybar/themes/config" -s "$HOME/.config/waybar/themes/style.css" &

# Remove the preventer file after successful completion
rm -f "$TEMP_FILE"

