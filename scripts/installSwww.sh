#!/bin/bash

# Define variables
APPLICATIONS_DIR="$HOME/Applications"
PROJECT_DIR="$APPLICATIONS_DIR/swww"  # Define project directory within Applications
BIN_DIR="/bin"

# Check if the Applications directory exists, if not, create it
if [ ! -d "$APPLICATIONS_DIR" ]; then
    mkdir -p "$APPLICATIONS_DIR"
fi

# Navigate to the Applications directory
cd "$APPLICATIONS_DIR" || exit

echo "Cloning swww repository..."
git clone https://github.com/LGFae/swww.git "$PROJECT_DIR"


# Navigate to the project directory
cd "$PROJECT_DIR" || exit

# Pull the latest changes from the repository
echo "Pulling the latest changes from the repository..."
git pull

# Build the project
echo "Building the project..."
cargo build --release

# Add project binaries to PATH in ~/.zshrc
sudo ln -sf "$PROJECT_DIR/target/release/swww" "$BIN_DIR/swww"
sudo ln -sf "$PROJECT_DIR/target/release/swww-daemon" "$BIN_DIR/swww-daemon"

echo "Installation completed successfully."
