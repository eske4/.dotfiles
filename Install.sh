#!/bin/bash

print_header() {
    echo -e "\n\e[1m$1\e[0m"
}

sudo -v


# Path to the scripts directory
SCRIPTS_DIR="scripts"

# Path to the package list file
PACKAGE_LIST="packages.txt"

# Check if the package list file exists
if [ ! -f "$PACKAGE_LIST" ]; then
    echo "Package list file not found: $PACKAGE_LIST"
    exit 1
fi

print_header "Installing yay"
bash "$SCRIPTS_DIR/installYay.sh" "$PACKAGE_LIST"

print_header "Installing packages"
bash "$SCRIPTS_DIR/installPackages.sh" "$PACKAGE_LIST"

print_header "configuring swayosd"
bash "$SCRIPTS_DIR/configure_swayosd.sh"

print_header "Installing Waybar"
bash "$SCRIPTS_DIR/installWaybar.sh"

print_header "installing eww"
bash "$SCRIPTS_DIR/installEww.sh"

print_header "Installing swww"
bash "$SCRIPTS_DIR/installSwww.sh"

print_header "Installing hypridle"
bash "$SCRIPTS_DIR/installHypridle.sh"

print_header "Installing hyprlock"
bash "$SCRIPTS_DIR/installHyprlock.sh"

print_header "Installing Pywal Discord"
bash "$SCRIPTS_DIR/installPywaldiscord.sh"

print_header "Installing Steam"
bash "$SCRIPTS_DIR/steam_installer.sh"

print_header "Fonts"
bash "$SCRIPTS_DIR/installFont.sh" "FiraCode" "https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip"
bash "$SCRIPTS_DIR/installFont.sh" "Maple" "https://github.com/subframe7536/maple-font/releases/download/v7.0-beta3/MapleMono-Hinted.zip"

print_header "Linking"
bash "$SCRIPTS_DIR/linkConfig.sh"

print_header "Shell"
# Change shell to Zsh
chsh -s $(which zsh)

print_header "configuring desktop services"
bash "$SCRIPTS_DIR/configure_desktopservices.sh"

# Print green text indicating shell change
echo -e "\e[32mShell changed to Zsh.\e[0m"

print_header "Configuration completed."
