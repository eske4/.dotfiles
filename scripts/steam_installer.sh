#!/bin/bash

# Create a temporary directory for Steam installation in the cache
SteamFolder="$HOME/steam_installation"
sudo mkdir -p "$SteamFolder"
cd "$SteamFolder" || exit

# Download the Steam installer package
sudo wget -q https://repo.steampowered.com/steam/archive/precise/steam_latest.deb

# Ensure the downloaded file exists
if [ -f "steam_latest.deb" ]; then
    # Extract the contents of the package

    sudo ar x $SteamFolder/steam_latest.deb
    # Extract control.tar.gz and data.tar.xz
    sudo tar -xf $SteamFolder/control.tar.gz
    sudo tar -xf $SteamFolder/data.tar.xz

    sudo tar -xvf $SteamFolder/control.tar.gz
    sudo tar -xvf $SteamFolder/data.tar.xz

    # Copy files to relevant system directories
    sudo cp -r $SteamFolder/etc/* /etc
    sudo cp -r $SteamFolder/lib/* /lib
    sudo cp -r $SteamFolder/usr/* /usr

    # Clean up temporary files
    sudo rm $SteamFolder/steam_latest.deb
    sudo rm -rf $SteamFolder

    echo "Steam has been installed successfully."
else
    echo "Failed to find the downloaded Steam installer file. Exiting."
    exit 1
fi
