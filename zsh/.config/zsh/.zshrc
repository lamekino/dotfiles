# --- setopt
setopt INTERACTIVE_COMMENTS # Comments in shell
setopt COMPLETE_ALIASES     # Preserves aliases in autocomplete
setopt PROMPT_SUBST         # Allow variables in prompt
setopt HIST_IGNORE_ALL_DUPS # ignore duplicate commands in history

# --- sourcing, autoloads & imports
# personal
[ -e "$XDG_CONFIG_HOME/personal/zsh" ] \
    && source "$XDG_CONFIG_HOME/personal/zsh"

[ -e "$XDG_CONFIG_HOME/dircolors" ] \
    && eval $(dircolors "$XDG_CONFIG_HOME/dircolors")

# initialize zoxide
command -v zoxide &>/dev/null \
    && eval "$(zoxide init zsh)"

# completion
autoload -Uz compinit \
    && compinit

autoload -U edit-command-line
zle -N edit-command-line

# --- zstyle
# use a menu selector
zstyle ":completion:*" menu select
# case insensitive completion
zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}" "r:|=*" "l:|=* r:|=*"
# set completion to show file attributes
zstyle ":completion:*" file-list all

# --- bindkey
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "^E" edit-command-line

# --- functions
# jumps back n dirs if $1 exists 1 otherwise
function ..() {
    if [ -z "$1" ]; then
        cd .. || return
    elif [ "$1" -gt 0 ]; then
        cd $(printf "../%.0s" $(seq 1 "$1")) || return
    fi
}
# uses regex to search history uses the whole argv and basically globs it
function hgrep()  {
    args=$(sed 's/ /.*/g' <<< ".*$@.*")
    history 1 | grep -E "$args"
}
# touch and make executable
function touchx() {
    touch "$1" && chmod +x "$1"
}
# mkdir and cd into it
function md() {
    mkdir -p "$1" && builtin cd "$1"
}
# pushd using z
# FIXME: using zoxide now
function pz() {
    builtin pushd $(z -e "$@")
}

# --- aliases
alias sudo="sudo " # so aliases can be run with sudo
alias dirs="dirs -v"
alias jobs="jobs -l"
alias pgrep="pgrep -l"
alias vi="nvim"
alias vim="nvim"
alias ipython="ipython --no-confirm-exit"
alias veracrypt="veracrypt -t"
alias tmux="tmux -2"
alias cls="clear"
alias tree="tree -a"
alias cite="source $ZDOTDIR/.zshrc" # cite your sources!
alias xres="xrdb ~/.Xresources"
alias wgetbulk="wget -np -nd -r --reject html"
alias stop="kill -STOP"
alias ppath="sed "s/:/\n/g" <<< $PATH"
alias screen="TERM=xterm-256color screen"
alias ipy="PAGER=less ipython"
alias pwpls="pwgen -1Bsy 20"
alias shrug="echo '¯\\_(ツ)_/¯'"
alias :q="echo '🤨'"
alias wttr="curl -s http://wttr.in"
alias ipecho="curl http://ipecho.net/plain; printf '\n'"

# --- os specific
case "$(uname -s)" in
    "Linux")
        source "$ZDOTDIR/sources/linux.zsh"
        grep -qi Microsoft /proc/version && \
            source "$ZDOTDIR/sources/wsl.zsh"

        # TODO: find a better way of doing this
        case $(cut -d" " -f1 /etc/issue) in
            "Arch") source "$ZDOTDIR/sources/arch-linux.zsh";;
            "Ubuntu"|"Debian") source "$ZDOTDIR/sources/debian.zsh";;
        esac
        ;;
    "Darwin") source "$ZDOTDIR/sources/mac.zsh" ;;
esac

# --- prompt
function prompt-color() {
    local color="$1"
    local string="$2"
    echo -n "%F{$color}$string%f"
}

function precmd-prompt() {
    local dir="$(prompt-color 12 '%~')"
    local err="$(prompt-color 1 '%?')"
    # local job="$(prompt-color 3 '%j')"

    # get git branch name
    local branch=$(git branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        local git="$(prompt-color 10 "*$branch"):"
    fi

    # _PROMPT="%(?..${err} )%(1j.${job} .)${git}${dir}"
    _PROMPT="%(?..${err} )${git}${dir}"
}

precmd_functions=(
    precmd-prompt
)

function zle-line-init zle-keymap-select {
    local norm="$(prompt-color 5 '>')"
    local ins="$(prompt-color 8 '%#')"

    case $KEYMAP in
        vicmd)      PROMPT="${_PROMPT}${norm} " ;;
        viins|main) PROMPT="${_PROMPT}${ins} " ;;
    esac
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
