install -d /run/$(id -u)/env
$DOTFILES/scripts/dump-env.py /run/$(id -u)/env

if [[ -z "$SSH_CONNECTION" ]]; then
    s6-rc -l /run/$(id -u)/s6-rc -v2 -up change "user"
fi

