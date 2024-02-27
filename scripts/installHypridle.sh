#!/bin/bash

# Set up directories
APPLICATIONS_DIR="$HOME/Applications"
PROJECT_DIR="$APPLICATIONS_DIR/hypridle"

# Ensure necessary directories exist
mkdir -p "$APPLICATIONS_DIR"


git clone https://github.com/hyprwm/hypridle "$PROJECT_DIR" 


# Navigate to the project directory
cd "$PROJECT_DIR" || { echo "Error: Unable to change directory to $PROJECT_DIR"; exit 1; }

# Run cmake to configure the build
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build || { echo "Error: CMake configuration failed."; exit 1; }

# Build the project
cmake --build ./build --config Release --target hypridle -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF` || { echo "Error: Build failed."; exit 1; }

# Install the built binaries
sudo cmake --install build || { echo "Error: Installation failed."; exit 1; }

echo "Hyprlock has been successfully installed."
