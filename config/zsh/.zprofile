$DOTFILES/scripts/system/update-env-dump

if ! pgrep -l -u $USER | grep -E 'sway' > /dev/null; then
    $DOTFILES/scripts/system/user-runlevel "user"
fi

if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$SSH_CONNECTION" ]; then
    if read -q "REPLY?Start Sway? "; then
        sway --unsupported-gpu
    fi
fi
