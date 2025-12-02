#!/bin/bash

# Lock file will indicates, that touchpad is off
DEVICE="synps/2-synaptics-touchpad"
LOCK_FILE="/tmp/touchpad.lock"

if [ -f "$LOCK_FILE" ]; then
    # Turn ON
    hyprctl keyword "device[$DEVICE]:enabled" "true"
    rm "$LOCK_FILE"
    echo "Enabled"
else
    # Turn OFF
    hyprctl keyword "device[$DEVICE]:enabled" "false"
    touch "$LOCK_FILE"
    echo "Disabled"
fi


# Toggling will work with Win + Fn (another mode of F's) + F12
