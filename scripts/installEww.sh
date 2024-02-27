#!/bin/bash

# Set up directories
APPLICATIONS_DIR="$HOME/Applications"
PROJECT_DIR="$APPLICATIONS_DIR/eww"

# Ensure necessary directories exist
mkdir -p "$APPLICATIONS_DIR"

# Change directory to HOME
cd "$HOME" && echo -n

# Clone eww repository
git clone https://github.com/elkowar/eww "$PROJECT_DIR"

cd "$PROJECT_DIR" || { echo "Error: Unable to change directory to $PROJECT_DIR"; exit 1; }

# Build eww with cargo
cargo build --release --no-default-features --features=wayland

# Change directory to target/release
cd target/release && echo -n

# Create a symbolic link
sudo ln -sf "$PROJECT_DIR/target/release/eww" /usr/local/bin > /dev/null 2>&1 && echo -e "\033[2K\033[1GCreating symbolic link... \033[32mOK\033[0m" || echo -e "\033[2K\033[1GCreating symbolic link... \033[31mFailed\033[0m"
sudo ln -sf "$PROJECT_DIR/target/release/eww" /bin > /dev/null 2>&1 && echo -e "\033[2K\033[1GCreating symbolic link... \033[32mOK\033[0m" || echo -e "\033[2K\033[1GCreating symbolic link... \033[31mFailed\033[0m"

