# new zshrc :D

# ZSH Options {{{
bindkey -v                  # Vi keybinds
bindkey '^R' history-incremental-search-backward
setopt INTERACTIVE_COMMENTS # Comments in shell
setopt COMPLETE_ALIASES     # Preserves aliases in autocomplete
setopt PROMPT_SUBST         # Allow variables in prompt
setopt HIST_IGNORE_ALL_DUPS # ignore duplicate commands in history
# }}}
# Imports and autoloads {{{
# personal stuff
[ -e "$XDG_CONFIG_HOME/personal/zsh" ] && source $XDG_CONFIG_HOME/personal/zsh
# for zsh packages installed to system
[ -e "$ZDOTDIR/local" ] \
    && source "$ZDOTDIR"/local/*.zsh \
    && source "$ZDOTDIR"/local/*.sh
# dircolors if exists
[ -e "$HOME/.dircolors" ] && eval $(dircolors -b $HOME/.dircolors)

# this makes comments *actually* readable in Alacritty
# NOTE: idk if this is actually needed anymore
[ -v ZSH_HIGHLIGHT_STYLES ] && ZSH_HIGHLIGHT_STYLES[comment]=fg=white


# Use ZSH tab completion
autoload -Uz compinit && compinit || echo "[$0] compinit failed" 1>&2

# Documentation
autoload run-help
alias help="run-help"

# Command line editing
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
# }}}
# ZStyle {{{
# set completion to show file attributes
zstyle ':completion:*' menu select
zstyle ':completion:*' file-list all
# }}}
# Aliases and functions {{{
# jumps back N dirs if $1 exists 1 otherwise
function ..() {
    if [ -z $1 ]; then
        builtin cd ..
    elif [ $1 -gt 0 ]; then
        builtin cd $(printf "../%.0s" $(seq 1 $1))
    fi
}
# uses regex to search history uses the whole argv and basically globs it
function hgrep()  {
    args=$(sed 's/ /.*/g' <<< ".*$@.*")
    history 1 | grep -E "$args"
}
# touch and make executable
function touchx() {
    touch $1 && chmod +x $1
}
# mkdir and cd into it
function md() {
    mkdir -p $1 && builtin cd $1
}
# pushd using z
function pz() {
    builtin pushd $(z -e "$@")
}

# Shadowing
alias sudo='sudo ' # so aliases can be run with sudo
alias dirs='dirs -v'
alias jobs='jobs -l'
alias pgrep='pgrep -l'
alias vi='nvim'
alias vim='nvim'
alias info="info --vi-keys"
alias veracrypt="veracrypt -t"
alias tmux="tmux -2"
alias cls="clear"
alias tree="tree -a"
# Short hand
alias cite="source $ZDOTDIR/.zshenv && source $ZDOTDIR/.zshrc" # cite your sources!
alias xres="xrdb ~/.Xresources"
alias wgetbulk='wget -np -nd -r --reject html'
alias stop='kill -STOP'
alias ppath='sed "s/:/\n/g" <<< $PATH'
alias screen='TERM=xterm-256color screen'
alias ipy="PAGER=less ipython"
alias pwpls="pwgen -1Bsy 20"
# Python
# alias python="python3"
# alias pip="pip3"

# Curl Utils
alias wttr='curl -s http://wttr.in'
alias ipecho='curl http://ipecho.net/plain; printf "\n"'
#
# }}}
# OS Specific {{{
case "$(uname -s)" in
    "Linux")
        source "$ZDOTDIR/sources/linux.zsh"
        grep -qi Microsoft /proc/version && \
            source "$ZDOTDIR/sources/wsl.zsh"

        # FIXME: find a better way of doing this
        case $(cut -d" " -f1 /etc/issue) in
            'Arch') source "$ZDOTDIR/sources/arch-linux.zsh";;
            'Ubuntu'|'Debian') source "$ZDOTDIR/sources/debian.zsh";;
        esac
        ;;
    "Darwin") source "$ZDOTDIR/sources/mac.zsh"
        ;;
esac
# }}}
# Prompt {{{
function color() {
    local color="$1"
    local string="$2"
    echo "%F{$color}$string%f"
}

_ZUSER="$(color 13 '%n')"
_ZHOST="$(color 12 '%m')"
_ZDIR="$(color 14 '%~')"
_ZERR="\\$(color 202 "%?")"
_ZJOB="\\$(color 172 "%%%j")"

function precmd_prompt() {
    _PROMPT="$_ZUSER:$_ZHOST<$_ZDIR%(1j.$_ZJOB.)%(?..$_ZERR)>"
}

# indicate vi insert/normal mode
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd) # normal mode
            PROMPT="${_PROMPT}| "
            ;;
        viins|main) # insert mode
            PROMPT="${_PROMPT}%# "
            ;;
    esac
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

precmd_functions=(
    precmd_prompt
)
[ -n $_Z_RESOLVE_SYMLINKS ] && precmd_functions+=_z_precmd

unfunction color
# }}}
# vim:foldmethod=marker
