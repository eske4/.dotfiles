#!/bin/bash
# Log file location
log_file="$HOME/.cache/wallpaper.log"
# Pywal executable path
wal_path="$HOME/.local/bin/wal"

# Cache file for holding the current wallpaper
cache_file="$HOME/.cache/current_wallpaper"
# Rasi file for managing current wallpaper settings
rasi_file="$HOME/.cache/current_wallpaper.rasi"

# Create cache file if not exists
if [ ! -f "$cache_file" ]; then
    touch "$cache_file"
    echo "$HOME/wallpapers/default.jpg" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f "$rasi_file" ]; then
    touch "$rasi_file"
    echo "* { current-image: url(\"$HOME/wallpapers/default.jpg\", height); }" > "$rasi_file"
fi

# Retrieve current wallpaper from cache
current_wallpaper=$(cat "$cache_file")

# Main switch case
case $1 in
    # Load wallpaper from cache of last session
    "init")
        if [ -f "$cache_file" ]; then
            "$wal_path" -q -i "$current_wallpaper"
             echo "generated theme color" >> "$log_file"
        else
            "$wal_path" -q -i ~/wallpapers/ >> "$log_file"
            echo "generated theme color for random wallpaper" >> "$log_file"
        fi
        ;;
    # Select wallpaper with rofi
    "select")
        selected=$(find "$HOME/wallpapers/" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) \
            -exec basename {} \; | sort -R | while read -r rfile; do
            echo -en "$rfile\x00icon\x1f$HOME/wallpapers/${rfile}\n"
        done | rofi -dmenu -replace)
        if [ -z "$selected" ]; then
            echo "No wallpaper selected" >> "$log_file"
            exit 1
        fi
        current_wallpaper="$HOME/wallpapers/$selected"

        # ----------------------------------------------------- 
        # Set the new wallpaper
        # ----------------------------------------------------- 
        transition_type="center"
        swww img $current_wallpaper \
            --transition-bezier .43,1.19,1,.4 \
            --transition-fps=144 \
            --transition-type=$transition_type \
            --transition-duration=0.4 \
            --transition-pos "$( hyprctl cursorpos )"
        
        "$wal_path" -q -i "$HOME/wallpapers/$selected" >> "$log_file"
        echo "changed wallpaper" >> "$log_file"
        ;;
    # Randomly select wallpaper
    *)
        "$wal_path" -q -i ~/wallpapers/
        echo "generated theme color for random wallpaper" >> "$log_file"
        ;;
esac

# ----------------------------------------------------- 
# Load current Pywal color scheme
# ----------------------------------------------------- 
source "$HOME/.cache/wal/colors.sh"
echo "Wallpaper: $current_wallpaper" >> "$log_file"

echo "loaded current color theme" >> "$log_file"

# ----------------------------------------------------- 
# Write selected wallpaper into cache files
# ----------------------------------------------------- 
echo "$current_wallpaper" > "$cache_file"
echo "* { current-image: url(\"$current_wallpaper\", height); }" > "$rasi_file"

echo "putted selected wallpaper into cache" >> "$log_file"
# ----------------------------------------------------- 
# Recolor terminal
# ----------------------------------------------------- 
~/.dotfiles/configs/.config/kitty/recolor-terminal.sh
echo "recolored terminal" >> "$log_file"
# ----------------------------------------------------- 
# Reload waybar if wallpaper selected
# ----------------------------------------------------- 
if [ "$1" = "select" ]; then
    ~/.dotfiles/configs/.config/waybar/launch-waybar.sh
fi

echo "reloaded waybar" >> "$log_file"

echo "Current wallpaper is: $current_wallpaper" >> "$log_file"
