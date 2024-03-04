#!/bin/bash

# Select wallpaper from wofi menu
WALLPAPER=$(wpg -l | rofi -dmenu -p "Select Wallpaper:")

# If wallpaper is selected, kill waybar, set wallpaper and restart waybar
if [[ -n $WALLPAPER ]]; then

	if [[ $(pidof waybar) ]]; then
		killall -9 waybar
	fi

	wpg -s $WALLPAPER && 
	sleep 0.1
	swww img $(readlink -f $HOME/.config/wpg/.current) --transition-duration 4 --transition-step 2 --transition-fps 144 &

    ~/.dotfiles/configs/.config/kitty/recolor-terminal.sh &
    pywal-discord -d $WALLPAPER &
	pywal-discord -t default &
    pywalfox update &

	WALLPAPER="${WALLPAPER%.*}"
	WALLPAPER="${WALLPAPER//_/ }"

	# send notification with a nice icon
	notify-send -t 6000 -i $HOME/.config/icons/wallpaper.svg "Wallpaper changed" "$(echo "$WALLPAPER" | sed -e "s/\b\(.\)/\u\1/g")"
fi

# If waybar is not running, start it 
if ! pgrep -x "waybar" > /dev/null
then
    $HOME/.dotfiles/configs/.config/waybar/launch-waybar.sh &
fi
