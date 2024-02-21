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

# Trigger the scripts inside the 'scripts' directory using bash
sudo bash "$SCRIPTS_DIR/installPackages.sh" "$PACKAGE_LIST"
bash "$SCRIPTS_DIR/installFont.sh"
bash "$SCRIPTS_DIR/linkConfig.sh"

print_header "Configuration completed."
