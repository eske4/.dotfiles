#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "git is not installed. Installing git..."
    sudo pacman -Sy --noconfirm git
fi

# Clone yay repository from AUR
git clone https://aur.archlinux.org/yay.git

# Change directory to yay
cd yay

# Build and install yay using makepkg
makepkg -si

# Clean up (optional)
cd ..
rm -rf yay

if command -v yay &> /dev/null; then
    echo "Yay has been installed successfully."
fi


