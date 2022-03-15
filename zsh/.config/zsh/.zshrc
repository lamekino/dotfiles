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
[ -e "$ZDOTDIR/sources" ] && source $ZDOTDIR/sources
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
alias python="python3"
alias pip="pip3"

# Curl Utils
alias wttr='curl -s http://wttr.in'
alias ipecho='curl http://ipecho.net/plain; printf "\n"'
# 
# }}}
# OS Specific {{{
case "$(uname -s)" in
    "Linux")
        alias grep='grep --color=auto'
        alias lablk="lsblk -o name,label,size,ro,type,mountpoint,uuid"
        alias ls='ls -pk --color=auto --group-directories-first'
        alias ll='ls -pklh --color=auto --group-directories-first'
        alias la='ls -pkah --color=auto --group-directories-first'
        alias lla='ls -pkalh --color=auto --group-directories-first'
        alias diff='diff --color=always'
        alias feh='feh -x --scale-down'
        alias feh-svg="feh --magick-timeout 1 $1"
        alias open='xdg-open'

        # Windows Subsystem for Linux
        if grep -qi Microsoft /proc/version
        then
            export DISPLAY=:0 # for xorg applications FIXME: broken in WSL2
            export USERPROFILE=/mnt/c/Users/$(whoami)
            alias open="/mnt/c/Windows/explorer.exe"
        fi

        # Distro specific
        case $(cut -d" " -f1 /etc/issue) in
            'Arch')
                # https://fosskers.github.io/aura/usage.html
                # https://github.com/fosskers/aura
                if command -v aura &>/dev/null
                then
                    alias pacman="aura --hotedit --unsuppress"
                    alias aura="aura --hotedit --unsuppress"
                fi
                alias hd="hexdump -C"
                ;;
            'Ubuntu'|'Debian')
                # this is hacky but it has behavior i want
                # mainly not having sudo in an alias
                alias aptup="sh <<< 'apt update && apt upgrade'"
                ;;
            *)
                ;;
        esac
        ;;
    "Darwin")
        # For macOS. I don't use macs very often, so this is quite barren
        # and maybe even out of date.
        export CLICOLOR=1
        alias ls='ls -pk'
        alias ll='ls -pkl'
        alias la='ls -pkla'
        alias lsblk='diskutil list'
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
