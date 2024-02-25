#!/bin/bash

# Enable and start the swayosd-libinput-backend.service
if sudo systemctl enable --now swayosd-libinput-backend.service; then
    echo "swayosd-libinput-backend.service has been enabled and started successfully."
else
    echo "Failed to enable or start swayosd-libinput-backend.service."
    exit 1
fi
