#!/bin/bash

# Set up directories
APPLICATIONS_DIR="$HOME/Applications"
PROJECT_DIR="$APPLICATIONS_DIR/Waybar"

# Ensure necessary directories exist
mkdir -p "$APPLICATIONS_DIR"

# Clone Waybar repository to the specified directory
git clone https://github.com/Alexays/Waybar "$PROJECT_DIR"

# Change directory to the project directory
cd "$PROJECT_DIR"

# Configure and build Waybar
meson build
cd build
ninja install

echo "Waybar has been successfully installed."
