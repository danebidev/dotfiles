# Start sway if not already running
if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$SSH_CONNECTION" ]; then
    if read -q "REPLY?Start Sway? "; then
        sway --unsupported-gpu
    fi
fi

fastfetch

# ------- Basic configuration -------
# vi keybinds
bindkey -v

setopt GLOBDOTS
setopt PROMPT_SUBST
setopt NO_CASE_GLOB
setopt AUTO_CD
# -----------------------------------

# ------------- Aliases -------------
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -l'
alias l='ls -lA'
alias cd='z'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias yolo='sudo pacman -Sy --needed --noconfirm archlinux-keyring && yay -Syu --noconfirm'
alias vim='nvim'

alias conf='cd $DOTFILES/config'
alias dots='cd $DOTFILES'
alias pkg='vim $DOTFILES/pkglist && sort $DOTFILES/pkglist -o $DOTFILES/pkglist'
# -----------------------------------

# ------------- Plugins -------------
autoload -Uz promptinit; promptinit
autoload -Uz compinit; compinit

# Use XDG_DATA_HOME if it's set, otherwise fallback to ~/.local/share
plugin_dir=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins
[ -d $plugin_dir ] || mkdir -p $plugin_dir

# Only configure fzf-tab if fzf is installed
if command -v fzf &> /dev/null; then
    # If fzf-tab is not installed, clone it
    if [ ! -d $plugin_dir/fzf-tab ]; then
        git clone https://github.com/Aloxaf/fzf-tab $plugin_dir/fzf-tab
    fi
    source $plugin_dir/fzf-tab/fzf-tab.plugin.zsh
fi

# If zsh-autosuggestions is not installed, clone it
if [ ! -d $plugin_dir/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $plugin_dir/zsh-autosuggestions
fi
source $plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh

# If fast-syntax-highlighting is not installed, clone it
if [ ! -d $plugin_dir/fast-syntax-highlighting ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $plugin_dir/fast-syntax-highlighting
fi
source $plugin_dir/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# -----------------------------------

# ------------ Functions ------------
# fzf over history
# Since I don't set HISTFILE, this will only work for the current session
function fh() {
    eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# Gets the weather for a given location
function weather() {
    curl wttr.in/$1
}
# -----------------------------------

# Configure zoxide
eval "$(zoxide init zsh)"
