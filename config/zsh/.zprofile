if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$SSH_CONNECTION" ]; then
    if read -q "REPLY?Start Sway? "; then
        dbus-launch sway --unsupported-gpu
    fi
fi
