[ -n "${DEBUG+1}" ]  && zmodload zsh/zprof

setopt COMPLETE_ALIASES
setopt HIST_IGNORE_ALL_DUPS
setopt INTERACTIVE_COMMENTS
setopt PROMPT_SUBST

function init() {
    local dir_colors=$(dircolors $XDG_CONFIG_HOME/dircolors)
    (( ${+commands[zoxide]} )) && local z_init=$(zoxide init zsh)

    local key="\$key" # when this gets eval'd it will become the loop iterator
    local autoload_key="autoload -Uz $key"
    local source_key="source $key"

    local -A files=( \
        ["$XDG_CONFIG_HOME/personal/zsh"]="[ -f $key ] && $source_key" \
        ["$XDG_CONFIG_HOME/dircolors"]="$dir_colors" \
        ["$ZDOTDIR/utils.zsh"]="$source_key" \
        ["$ZDOTDIR/prompt.zsh"]="$source_key" \
    )
    local -A autoloads=( \
        ["compinit"]="$autoload_key && $key" \
        ["edit-command-line"]="$autoload_key && zle -N $key" \
    )
    local -A init_cmds=( \
        ["zoxide"]="$z_init" \
    )

    for key cmd in ${(kv)files} ${(kv)autoloads} ${(kv)init_cmds}; do
        eval "$cmd"
    done

    unfunction "$0"
}
init

# bindkey
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "^E" edit-command-line

# zstyle
zstyle ":completion:*" menu select # use a menu selector
zstyle ":completion:*" file-list all # set completion to show file attributes
zstyle ":completion:*" matcher-list "" \
    "m:{a-zA-Z}={A-Za-z}" "r:|=*" "l:|=* r:|=*" # case insensitive completion

# --- aliases
alias sudo="sudo " # makes aliases work with sudo
alias \$=" " # copy paste from archwiki
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
alias pyserver="python3 -m http.server"
alias youtube-dl="yt-dlp"
alias zsh_startuptime="time DEBUG=1 zsh -i -c exit"

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

# bad habits
alias :q="echo '🤭'"
alias cls="echo '🤨'"
alias dir="echo '🖕'"
alias sl=" echo -e '\x1b[1;31mSet-Location\x1b[0;31m: The term \
'Set-Location' is not recognized as a name of a cmdlet, function, script \
file, or executable program. Check the spelling of the name, or if a path \
was included, verify that the path is correct and try again\x1b[0m'"

case $(uname -s) in
Linux)
    alias grep='grep --color=auto'
    alias lablk="lsblk -o name,label,size,ro,type,mountpoint,uuid"
    alias ls='LC_ALL=C ls -pk --color=auto --group-directories-first'
    alias ll='LC_ALL=C ls -pklh --color=auto --group-directories-first'
    alias la='LC_ALL=C ls -pkah --color=auto --group-directories-first'
    alias lla='LC_ALL=C ls -pkalh --color=auto --group-directories-first'
    alias diff='diff --color=always'
    alias feh='feh -x --scale-down'
    alias open='xdg-open'
    alias trash='gio trash'
    alias hd="hexdump -C"

    if grep -qi Microsoft /proc/version; then
        export DISPLAY=:0 # for xorg applications FIXME: broken in WSL2
        export USERPROFILE=/mnt/c/Users/$(whoami)
        alias open="/mnt/c/Windows/explorer.exe"
        alias xclip="/mnt/c/Windows/system32/clip.exe"
    fi

    if grep -q Arch /etc/issue && (( ${+commands[aura]} )); then
        alias pacman="aura --hotedit --unsuppress"
        alias aura="aura --hotedit --unsuppress"
    fi
    ;;
Darwin)
    export CLICOLOR=1
    alias ls='ls -pk'
    alias ll='ls -pkl'
    alias la='ls -pkla'
    alias lsblk='diskutil list'
    ;;
esac

[ -n "${DEBUG+1}" ]  && zprof
