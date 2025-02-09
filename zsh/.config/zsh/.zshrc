# start profiling and logging if debug is set
[ -n "${DEBUG+1}" ] && zmodload "zsh/zprof" && set -xe

## shell options
setopt COMPLETE_ALIASES
setopt HIST_IGNORE_ALL_DUPS
setopt INTERACTIVE_COMMENTS
setopt PROMPT_SUBST

## keybinds
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "^E" edit-command-line

## tab config
zstyle ":completion:*" menu select # use a menu selector
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # colorful menu
zstyle ":completion:*" matcher-list "" \
    "m:{a-zA-Z}={A-Za-z}" "r:|=*" "l:|=* r:|=*" # case insensitive completion

## aliases
# general
alias sudo="sudo " # makes aliases work with sudo
alias \$=" " # copy paste from archwiki
alias \@="sgpt" # terminal chatgpt
alias dirs="dirs -v"
alias jobs="jobs -l"
alias js="jobs -l"
alias pgrep="pgrep -l"
alias vim="nvim"
alias ipython="ipython --no-confirm-exit"
alias tmux="tmux -2"
alias tree="tree -a"
alias t="tree -F"
alias td="tree -F -L"
alias stop="kill -STOP"
alias pyserver="python3 -m http.server"
alias youtube-dl="yt-dlp"
alias zsh_debug="time DEBUG=1 zsh -i -c exit"
alias Z="zoxide"
alias fs="dfc -T -p /dev 2>/dev/null"

# files
alias tmuxconf="$EDITOR $XDG_CONFIG_HOME/tmux/tmux.conf"
alias vimrc="$EDITOR $XDG_CONFIG_HOME/nvim/"
alias zshrc="$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc"
alias zshenv="$EDITOR $XDG_CONFIG_HOME/zsh/.zshenv"

# git
alias gl="git log"
alias gs="git status"
alias gp="git pull"
alias gP="git push"
alias gc="git commit"
alias gr="git root"
alias g~="printf 'pushed: '; pushd \$(git root)"

# security
alias pwpls="pwgen -1Bsy 20"
alias veracrypt="veracrypt -t"

# curl/wget
alias ipecho="printf 'Public IP: %s\n' \$(curl -s http://ipecho.net/plain)"
alias wttr="curl -s http://wttr.in"
alias wgetbulk="wget -np -nd -r --reject html"

# misc
alias cite="source $ZDOTDIR/.zshrc" # cite your sources!
alias src-update="src-update ~/.config/build-list"
alias packer-upgrade="nvim -c 'autocmd User PackerComplete quitall' -c \
'PackerSync'"

# bad habits
alias :q="echo -e '\x1b[31mE492: Not a shell command: q\x1b[0m'"

# real windows 11 ux in 2023
alias dir="sleep .4; echo 'The system cannot find the path specified.'"
alias cls="sleep .4; echo '‘cls’ is not recognized as an internal or \
external command, operable program or batch file.'"
alias sl="sleep .4; echo -e '\x1b[1;31mSet-Location\x1b[0;31m: The term \
'Set-Location' is not recognized as a name of a cmdlet, function, script file, \
or executable program. Check the spelling of the name, or if a path was \
included, verify that the path is correct and try again\x1b[0m'"

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

    if [ -n "$WSL_DISTRO_NAME" ]; then
        alias open="/mnt/c/Windows/explorer.exe"
        alias xclip="/mnt/c/Windows/system32/clip.exe"
        alias pwsh="/mnt/c/Program\ Files/PowerShell/7/pwsh.exe"

        autoload -Uz wsl-x11-setup && wsl-x11-setup
    fi

    if [ -f /etc/issue ]; then
        read distro _ < /etc/issue
    fi

    case "$distro" in
    Arch)
        if (( ${+commands[aura]} )); then
            alias pacman="aura --hotedit --unsuppress"
            alias aura="aura --hotedit --unsuppress"
        fi
        ;;
    *)
    esac
    unset distro
    ;;
Darwin)
    export CLICOLOR=1
    alias ls='ls -pk'
    alias ll='ls -pkl'
    alias la='ls -pkla'
    alias lsblk='diskutil list'
    ;;
esac

## functions
# enables rehash by sending zsh processes SIGUSR1
# https://wiki.archlinux.org/title/Zsh#On-demand_rehash
function TRAPUSR1() { rehash }

# initializes autoloads
function load_all_the_stuff_pls() {
    local dir_colors=$(dircolors $XDG_CONFIG_HOME/dircolors)
    (( ${+commands[zoxide]} )) && local z_init=$(zoxide init zsh)

    local key="\$key" # when this gets eval'd it will become the loop iterator
    local autoload_key="autoload -Uz $key"
    local source_key="[ -f $key ] && source $key"

    local -A files=( \
        ["$XDG_CONFIG_HOME/personal/zsh"]="$source_key" \
        ["$XDG_CONFIG_HOME/dircolors"]="$dir_colors" \
    )
    local -A autoloads=( \
        ["compinit"]="$autoload_key && $key" \
        ["edit-command-line"]="$autoload_key && zle -N $key" \
        ["my-init-prompt"]="$autoload_key && $key"
        ["my-extra-functions"]="$autoload_key && $key" \
    )
    local -A init_cmds=( \
        ["zoxide"]="$z_init" \
    )

    for key cmd in ${(kv)files} ${(kv)autoloads} ${(kv)init_cmds}; do
        eval "$cmd"
    done

    unfunction "$0"
}

## finishing up
# load autoloads
load_all_the_stuff_pls

# finish profiling if in debug
[ -n "${DEBUG+1}" ] && zprof

# always return sucess
return 0
