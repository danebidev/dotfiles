if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    if read -q "REPLY?Start Sway? "; then
        dbus-run-session sway --unsupported-gpu
    fi
fi

fastfetch

bindkey -v

setopt GLOBDOTS
setopt PROMPT_SUBST
setopt NO_CASE_GLOB
setopt AUTO_CD

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

autoload -Uz promptinit; promptinit
autoload -Uz compinit; compinit

plugin_dir=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins
[ -d $plugin_dir ] || mkdir -p $plugin_dir

if command -v fzf &> /dev/null; then
    if [ ! -d $plugin_dir/fzf-tab ]; then
        git clone https://github.com/Aloxaf/fzf-tab $plugin_dir/fzf-tab
    fi
    source $plugin_dir/fzf-tab/fzf-tab.plugin.zsh
fi

if [ ! -d $plugin_dir/fast-syntax-highlighting ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $plugin_dir/fast-syntax-highlighting
fi
source $plugin_dir/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

function colormap() for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done

function fh() {
    eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

function weather() {
    curl wttr.in/$1
}

eval "$(zoxide init zsh)"
