export PATH="$HOME/bin:$HOME/.local/share/cargo/bin:$PATH"
typeset -U path

export PROMPT='%F{blue}%~%f $ '
export EDITOR='nvim'
export DOTFILES=${$(realpath ~/.config/zsh/.zshenv):h:h:h}
export XDG_CURRENT_DESKTOP=sway
export XDG_RUNTIME_DIR="/run/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"
export GPG_TTY=$(tty)

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# Nvidia
export LIBVA_DRIVER_NAME=nvidia
export XDG_SESSION_TYPE=wayland
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
