#!/bin/bash
# Log file location
log_file="$HOME/.cache/wallpaper.log"
wal_path=$HOME/.local/bin/wal


# Cache file for holding the current wallpaper

cache_file="$HOME/.cache/current_wallpaper"
rasi_file="$HOME/.cache/current_wallpaper.rasi"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/wallpapers/default.jpg" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/wallpapers/default.jpg\", height); }" > "$rasi_file"
fi

current_wallpaper=$(cat "$cache_file")

case $1 in

    # Load wallpaper from .cache of last session 
    "init")
        if [ -f $cache_file ]; then
            $wal_path -q -i $current_wallpaper
        else
            $wal_path -q -i ~/wallpapers/ >> "$log_file"
        fi
    ;;

    # Select wallpaper with wofi
    "select")

        selected=$( find "$HOME/wallpapers/" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
        do
            echo -en "$rfile\x00icon\x1f$HOME/wallpapers/${rfile}\n"
        done | rofi -dmenu -replace)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected" >> "$log_file"
            exit 1
        fi
        $wal_path -q -i ~/wallpapers/$selected

    ;;

    # Randomly select wallpaper 
    *)
        $wal_path -q -i ~/wallpapers/
    ;;

esac

# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source "$HOME/.cache/wal/colors.sh"
echo "Wallpaper: $wallpaper" >> "$log_file"

# ----------------------------------------------------- 
# Write selected wallpaper into .cache files
# ----------------------------------------------------- 
echo "$wallpaper" > "$cache_file"
echo "* { current-image: url(\"$wallpaper\", height); }" > "$rasi_file"

# ----------------------------------------------------- 
# get wallpaper image name
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|$HOME/wallpapers/||g")

# ----------------------------------------------------- 
# Reload waybar with new colors
# -----------------------------------------------------
~/.dotfiles/configs/.config/waybar/launch.sh

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------
transition_type="center"
# transition_type="outer"
# transition_type="random"

swww img $wallpaper \
    --transition-bezier .43,1.19,1,.8 \
    --transition-fps=144 \
    --transition-type=$transition_type \
    --transition-duration=0.5 \
    --transition-pos "$( hyprctl cursorpos )"

exit 0
