fastfetch

# ------- Basic configuration -------
# vi keybinds
bindkey -v

setopt GLOBDOTS
setopt PROMPT_SUBST
setopt NO_CASE_GLOB
setopt AUTO_CD

# ------------- Aliases -------------
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -l'
alias l='ls -lA'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias vim='nvim'

alias conf='cd $DOTFILES/config'
alias dots='cd $DOTFILES'

# ------------- Plugins -------------
# Use XDG_DATA_HOME if it's set, otherwise fallback to ~/.local/share
plugin_dir=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins
[ -d $plugin_dir ] || mkdir -p $plugin_dir

# Use $XDG_CACHE_HOME for compdump if it's set, otherwise fallback to ~/.cache
compdump_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
[ -d $compdump_dir ] || mkdir -p $compdump_dir
autoload -Uz compinit && compinit -d $compdump_dir

# Only configure fzf-tab if fzf is installed
if command -v fzf &> /dev/null; then
    if [ ! -d $plugin_dir/fzf-tab ]; then
        git clone https://github.com/Aloxaf/fzf-tab $plugin_dir/fzf-tab
    fi
    source $plugin_dir/fzf-tab/fzf-tab.plugin.zsh
fi

# If plugins are not installed, clone them
if [ ! -d $plugin_dir/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $plugin_dir/zsh-autosuggestions
fi
source $plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ ! -d $plugin_dir/fast-syntax-highlighting ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $plugin_dir/fast-syntax-highlighting
fi
source $plugin_dir/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# ------------ Functions ------------
# fzf over history
# Since I don't set HISTFILE, this will only work for the current session
fh() {
    eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# Gets the weather for a given location
weather() {
    curl wttr.in/$1
}
