#!/bin/bash
sudo usermod -a -G input $USER
echo -e "\e[32mAdded user to input group\e[0m"

sudo systemctl enable mpd
echo -e "\e[32mAdded mdp to system\e[0m"