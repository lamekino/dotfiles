# --- setopt
setopt INTERACTIVE_COMMENTS # comments in shell
setopt COMPLETE_ALIASES     # preserves aliases in autocomplete
setopt PROMPT_SUBST         # allow variables in prompt
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

# run initialization functions
for init in "$ZDOTDIR"/fpath/init-*; do
    autoload -Uz "$init" \
        && "$(basename "$init")"
done

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
alias js="jobs -l"
alias pgrep="pgrep -l"
alias vim="nvim"
alias gvim="nvim-qt"
alias ipython="ipython --no-confirm-exit"
alias py="ipython --no-confirm-exit"
alias tmux="tmux -2"
alias tree="tree -a"
alias t="tree"
alias td="tree -L"
alias yy="xclip -selection clipboard"
alias stop="kill -STOP"
alias ppath="tr ':' '\n' <<< $PATH" # this is static...

# files
alias tmuxconf="$EDITOR $XDG_CONFIG_HOME/tmux/tmux.conf"
alias vimrc="$EDITOR $XDG_CONFIG_HOME/nvim/"
alias zshrc="$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc"
alias zshenv="$EDITOR $XDG_CONFIG_HOME/zsh/.zshenv"

# git
alias gitl="git log --oneline --graph"

# security
alias pwpls="pwgen -1Bsy 20"
alias veracrypt="veracrypt -t"

# curl/wget
alias ipecho="curl http://ipecho.net/plain; printf '\n'"
alias wttr="curl -s http://wttr.in"
alias wgetbulk="wget -np -nd -r --reject html"

# misc
alias cite="source $ZDOTDIR/.zshrc" # cite your sources!
alias :q="echo '🤭'"
alias cls="echo '🤨'"
alias dir="echo '🖕'"

# --- os specific
case "$(uname -s)" in
    "Linux")
        source "$ZDOTDIR/os/linux.zsh"
        grep -qi Microsoft /proc/version && \
            source "$ZDOTDIR/os/wsl.zsh"

        case $(cut -d" " -f1 /etc/issue) in
            "Arch") source "$ZDOTDIR/os/archlinux.zsh";;
            "Ubuntu"|"Debian") source "$ZDOTDIR/os/debian.zsh";;
        esac
        ;;
    "Darwin") source "$ZDOTDIR/sources/mac.zsh" ;;
esac

# --- source init files
source "$ZDOTDIR/sources/utils.zsh"
source "$ZDOTDIR/sources/prompt.zsh"
