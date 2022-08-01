# --- setopt
setopt INTERACTIVE_COMMENTS # Comments in shell
setopt COMPLETE_ALIASES     # Preserves aliases in autocomplete
setopt PROMPT_SUBST         # Allow variables in prompt
setopt HIST_IGNORE_ALL_DUPS # ignore duplicate commands in history

# --- sourcing & imports
# personal
[ -e "$XDG_CONFIG_HOME/personal/zsh" ] \
    && source "$XDG_CONFIG_HOME/personal/zsh"

# dircolors
[ -e "$XDG_CONFIG_HOME/dircolors" ] \
    && eval $(dircolors "$XDG_CONFIG_HOME/dircolors")

# initialize zoxide
command -v zoxide &>/dev/null \
    && eval "$(zoxide init zsh)"

# --- autoloads
# completion
autoload -Uz compinit \
    && compinit

# command editor
autoload -Uz edit-command-line \
    && zle -N edit-command-line

# helpful functions
autoload -Uz utils-init.zsh \
    && utils-init.zsh

# prompt
autoload -Uz my-prompt-init.zsh \
    && my-prompt-init.zsh

# --- bindkey
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "^E" edit-command-line

# --- zstyle
# use a menu selector
zstyle ":completion:*" menu select
# case insensitive completion
zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}" "r:|=*" "l:|=* r:|=*"
# set completion to show file attributes
zstyle ":completion:*" file-list all

# --- aliases
alias sudo="sudo " # so aliases can be run with sudo
alias dirs="dirs -v"
alias jobs="jobs -l"
alias pgrep="pgrep -l"
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
alias ppath="tr ':' '\n' <<< $PATH" # this is static...
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
