#!/bin/bash

print_header() {
    echo -e "\n\e[1m$1\e[0m"
}

print_header Font

# Define the GitHub API URL for Fira Code releases
URL="https://api.github.com/repos/tonsky/FiraCode/releases/latest"

# Fetching the latest release information using curl
response=$(curl -s "$URL")

# Extracting the tag name (version) and asset download URL
tag_name=$(echo "$response" | grep -o '"tag_name": ".*"' | cut -d '"' -f4)
asset_download_url=$(echo "$response" | grep -o '"browser_download_url": ".*"' | cut -d '"' -f4)

# Constructing the download link
download_link="$asset_download_url"

# Specify the URL of the latest release of FiraCode Nerd Font
FONT_URL=$download_link

# Specify the directory where the font files will be installed
FONT_DIR="$HOME/.local/share/fonts"

# Create the font directory if it doesn't exist
if ! mkdir -p "$FONT_DIR"; then
    echo -e "\e[31mFailed to create font directory.\e[0m"
    exit 1
fi

# Download the font archive
echo -n "Downloading FiraCode Nerd Font version $tag_name: "
if wget --spider "$FONT_URL" 2>/dev/null; then
    wget --progress=bar:force:noscroll -O "$FONT_DIR/FiraCode.zip" "$FONT_URL" > /dev/null 2>&1 &
    pid_download=$! # Store the process ID of the background process

    while kill -0 $pid_download > /dev/null 2>&1; do
        echo -n "."
        sleep 0.5
    done
    wait $pid_download

    # Clear the line
    echo -ne "\r\033[2K"

    # Check if the download was successful
    if [ $? -ne 0 ]; then
        echo -e "\e[31mFailed to download FiraCode Nerd Font.\e[0m"
        exit 1
    fi

    # Extract the font files
    echo -n "Extracting FiraCode Nerd Font: "
    unzip -o "$FONT_DIR/FiraCode.zip" -d "$FONT_DIR" > /dev/null 2>&1 &
    pid_extraction=$! # Store the process ID of the background process

    while kill -0 $pid_extraction > /dev/null 2>&1; do
        echo -n "."
        sleep 0.5
    done
    wait $pid_extraction

    # Clear the line
    echo -ne "\r\033[2K"

    # Check if unzip was successful
    if [ $? -ne 0 ]; then
        echo -e "\e[31mFailed to extract FiraCode Nerd Font.\e[0m"
        exit 1
    fi

    # Clean up - remove the font archive
    echo -n "Cleaning up: "
    rm "$FONT_DIR/FiraCode.zip" > /dev/null 2>&1 &
    pid_cleanup=$! # Store the process ID of the background process

    while kill -0 $pid_cleanup > /dev/null 2>&1; do
        echo -n "."
        sleep 0.5
    done
    wait $pid_cleanup

    # Clear the line
    echo -ne "\r\033[2K"

    # Check if cleanup was successful
    if [ $? -ne 0 ]; then
        echo -e "\e[31mFailed to remove font archive.\e[0m"
        exit 1
    fi

    # Refresh font cache
    echo -n "Refreshing font cache: "
    fc-cache -fv > /dev/null 2>&1 &
    pid_refresh=$! # Store the process ID of the background process

    while kill -0 $pid_refresh > /dev/null 2>&1; do
        echo -n "."
        sleep 0.5
    done
    wait $pid_refresh

    # Clear the line
    echo -ne "\r\033[2K"

    # Check if font cache was refreshed successfully
    if [ $? -ne 0 ]; then
        echo -e "\e[31mFailed to refresh font cache.\e[0m"
        exit 1
    fi
else
    # Clear the line
    echo -ne "\r\033[2K"

    echo -e "\e[31mFailed to locate FiraCode Nerd Font download URL.\e[0m"
    exit 1
fi

echo -e "\e[32mFiraCode Nerd Font has been installed.\e[0m"
