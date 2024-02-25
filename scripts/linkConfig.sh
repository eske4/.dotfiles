#!/bin/bash

# Define ANSI color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Define variables
DOTFILES_DIR="$HOME/.dotfiles/configs/"
TARGET_DIR="$HOME"

# Check if the dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}Error: Dotfiles directory '$DOTFILES_DIR' not found.${NC}" >&2
    exit 1
fi

# Navigate to the dotfiles directory
cd "$DOTFILES_DIR" || { echo "${RED}Error: Unable to change directory to $DOTFILES_DIR.${NC}" >&2; exit 1; }

# Use Stow to manage dotfiles
if stow -t "$TARGET_DIR" . > /dev/null 2>&1; then
    echo -e "${GREEN}Dotfiles successfully linked to $TARGET_DIR.${NC}"
else
    echo -e "${RED}Error: Failed to stow dotfiles.${NC}" >&2
    exit 1
fi
