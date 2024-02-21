#!/bin/bash

# Check if the font name and URL are provided
if [ "$#" -ne 2 ]; then
    echo -e "\e[31mUsage: $0 <FontName> <FontURL>\e[0m"
    exit 1
fi

# Font name and URL
FONT_NAME="$1"
FONT_URL="$2"

# Specify the directory where the font files will be installed
FONT_DIR="$HOME/.local/share/fonts"

# Create the font directory if it doesn't exist
if ! mkdir -p "$FONT_DIR"; then
    echo -e "\e[31mFailed to create font directory.\e[0m"
    exit 1
fi

# Download the font archive
echo -n "Downloading $FONT_NAME: "
if wget --spider "$FONT_URL" 2>/dev/null; then
    wget --progress=bar:force:noscroll -O "$FONT_DIR/$FONT_NAME.zip" "$FONT_URL" > /dev/null 2>&1 &
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
        echo -e "\e[31mFailed to download $FONT_NAME.\e[0m"
        exit 1
    fi

    # Extract the font files
    echo -n "Extracting $FONT_NAME: "
    unzip -o "$FONT_DIR/$FONT_NAME.zip" -d "$FONT_DIR" > /dev/null 2>&1 &
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
        echo -e "\e[31mFailed to extract $FONT_NAME.\e[0m"
        exit 1
    fi

    # Clean up - remove the font archive
    echo -n "Cleaning up: "
    rm "$FONT_DIR/$FONT_NAME.zip" > /dev/null 2>&1 &
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

    echo -e "\e[31mFailed to locate $FONT_NAME download URL.\e[0m"
    exit 1
fi

echo -e "\e[32m$FONT_NAME has been installed.\e[0m"

