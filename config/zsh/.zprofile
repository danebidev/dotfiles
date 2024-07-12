$DOTFILES/scripts/system/update-env-dump

if [[ -z "$SSH_CONNECTION" ]]; then
    $DOTFILES/scripts/system/user-runlevel "user"
fi

