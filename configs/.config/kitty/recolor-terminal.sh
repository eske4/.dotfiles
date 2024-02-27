#!/bin/bash
# Read the content of colors-kitty.conf
content=$(cat ~/.cache/wal/colors-kitty.conf)

# Define the custom configurations
custom_config="font_family Maple Mono
bold_font auto
italic_font auto
bold_italic_font auto

background_opacity 0.72

font_size 12"

# Create a temporary file to store the combined configurations
temp_file=$(mktemp)

# Insert custom configurations before the content of colors-kitty.conf
echo "$custom_config" > "$temp_file"
echo "$content" >> "$temp_file"

# Copy the combined configurations to the destination
cp "$temp_file" ~/.dotfiles/configs/.config/kitty/kitty.conf


