#!/bin/bash

# Change directory to HOME
cd "$HOME" && echo -n

# Clone eww repository
git clone https://github.com/elkowar/eww > /dev/null 2>&1

# Change directory to eww
cd eww 

# Build eww with cargo
cargo build --release --no-default-features --features=wayland > /dev/null 2>&1

# Change directory to target/release
cd target/release && echo -n

# Create a symbolic link
sudo ln -sf "$HOME/eww/target/release/eww" /usr/local/bin > /dev/null 2>&1 && echo -e "\033[2K\033[1GCreating symbolic link... \033[32mOK\033[0m" || echo -e "\033[2K\033[1GCreating symbolic link... \033[31mFailed\033[0m"

