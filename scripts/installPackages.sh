#!/bin/bash

# Path to the file containing the list of packages
PACKAGE_LIST="$1"


# Function to print headers
print_header() {
    echo -e "\n\e[1m$1\e[0m"
}

print_header Packages

# Check if the package list file exists
if [ ! -f "$PACKAGE_LIST" ]; then
    echo "Package list file not found: $PACKAGE_LIST"
    exit 1
fi


# Install packages using pacman
while IFS= read -r package || [[ -n "$package" ]]; do
    # Display a message indicating the package is being installed
    echo -n "Installing package: $package ..."
    sudo pacman -S --noconfirm "$package" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "\e[32m[OK]\e[0m"
    else
        echo -e "\e[31m[Failed]\e[0m"
    fi
done < "$PACKAGE_LIST"