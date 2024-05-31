# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000
setopt autocd #cd without typing 'cd'
setopt correctall #Auto correction of typed commands
setopt hist_ignore_space # Ignore commands in history if prefixed with a space
unsetopt beep

# End of lines configured by zsh-newuser-install

PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '
# Completion Settings 
zstyle :compinstall filename '/home/doozku/.zshrc'

autoload -Uz compinit promptinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

_comp_options+=(globdots) # Include hidden files 


# Set vim bindings only when not inside of emacs
if [[ -z $INSIDE_EMACS ]]; then
    bindkey -v
    # Use vim keys in tab complete menu 
    bindkey -M menuselect 'h' vi-backward-char
    bindkey -M menuselect 'k' vi-up-line-or-history
    bindkey -M menuselect 'l' vi-forward-char
    bindkey -M menuselect 'j' vi-down-line-or-history
fi

export KEYTIMEOUT=1
# Change cursor shape for different vi modes 
# Credit to luke smith for a lot of these configs
zle-keymap-select ()
{
    case "$KEYMAP" in
        vicmd) echo -ne '\e[1 q';; # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init ()
{
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere
    echo -ne '\e[5 q' # beam
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;}

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lfub -last-dir-path="$tmp" "$@" # lfub is my custom lf wrapper for img support
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Set a keybind to auto run doas !!
bindkey -s '^r' 'doas !!\n'

# Configure zsh to work nice with vterm in Emacs
vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# Configure zsh to work with EAT Shell
[ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
    source "$EAT_SHELL_INTEGRATION_DIR/zsh"

# Uses Zoxide and then calls what is essentially the 'fv' alias
zv() {
    cd "$(zoxide query $1)" && fd --type f --hidden --exclude .git |
        fzf -m --bind one:accept --preview 'bat --style numbers,changes --color=always {} | head -500' |
        xargs -r nvim
}

# Enable colors 
autoload -U colors && colors

# Edit line in vim with ctrl-e 
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Set aliases
[ -f "$HOME/.config/zsh/.aliasrc" ] && source "$HOME/.config/zsh/.aliasrc"

# Setup zoxide
eval "$(zoxide init zsh)"

# Setup direnv
eval "$(direnv hook zsh)"

# Setup zsh-syntax-highlighting and auto-completion
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Set auto-completion keybindings 
bindkey '^ ' autosuggest-accept
bindkey '^ENTER' autosuggest-execute
bindkey '^F' autosuggest-execute

# Set up fzf integration
# This adds the following keybinds:
# Ctrl+t - List files and folders and inserts them in prompt
# Ctrl+r - Search history of shell commands
# Alt+c - Fuzzy change directory
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh


# Load wal themes
cat $HOME/.cache/wal/sequences
