# vim:ft=zsh

# general
alias sudo="sudo " # makes aliases work with sudo
alias dirs="dirs -v"
alias jobs="jobs -l"
alias pgrep="pgrep -l"
alias vim="nvim"
alias ipython="ipython --no-confirm-exit"
alias tmux="tmux -2"
alias tree="tree -a"
alias t="tree -F"
alias td="tree -F -L"
alias stop="kill -STOP"
alias pyserver="python3 -m http.server"
alias youtube-dl="yt-dlp" # rip
alias zsh_debug="time DEBUG=1 zsh -i -c exit"
alias Z="zoxide"
alias fs="dfc -T -p /dev 2>/dev/null"
alias neofetch="fastfetch --config neofetch" # 2025, rip neofetch ;-;
alias vi="nvim -u NONE"

# config edits
alias tmux.conf="$EDITOR $XDG_CONFIG_HOME/tmux/tmux.conf"
alias zshenv="$EDITOR $XDG_CONFIG_HOME/zsh/.zshenv"

# curl/wget utils
alias ipecho="printf 'Public IP: %s\n' \$(curl -s http://ipecho.net/plain)"
alias wttr="curl -s http://wttr.in"
alias wgetbulk="wget -np -nd -r --reject html"

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
    alias ls='LC_ALL=C \ls -pk --color=auto --group-directories-first'
    alias ll='LC_ALL=C \ls -pklh --color=auto --group-directories-first'
    alias la='LC_ALL=C \ls -pkah --color=auto --group-directories-first'
    alias lla='LC_ALL=C \ls -pkalh --color=auto --group-directories-first'
    alias diff='diff --color=always'
    alias open='xdg-open'
    alias hd="hexdump -C"

    if [ -e /proc/sys/fs/binfmt_misc/WSLInterop ]; then
        if (( WSL_USE_X11 )); then
            export DISPLAY="$(ip route show default | cut -d' ' -f3 )"
        fi

        alias open="/mnt/c/Windows/explorer.exe"
        alias xclip="/mnt/c/Windows/system32/clip.exe"
        alias pwsh="/mnt/c/Program\ Files/PowerShell/7/pwsh.exe"
    fi

    case "$(cat /etc/os-release 2>/dev/null | grep '^ID=' | cut -d= -f2)" in
    ubuntu)
        alias bat="batcat"
        ;;
    arch)
        ;;
    esac
    ;;
Darwin)
    export CLICOLOR=1
    alias ls='ls -pk'
    alias ll='ls -pkl'
    alias la='ls -pkla'
    alias lsblk='diskutil list'
    ;;
esac
