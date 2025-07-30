alias grep='grep --color=auto'
alias diff='diff --color=always'
alias ls='LC_ALL=C ls -pk --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -a'
alias open='xdg-open'

# check if in wsl
if [ -e /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    if (( WSL_USE_X11 )); then
        export DISPLAY="$(ip route show default | cut -d' ' -f3 )"
    fi

    alias open="/mnt/c/Windows/explorer.exe"
    alias xclip="/mnt/c/Windows/system32/clip.exe"
    alias pwsh="/mnt/c/Program\ Files/PowerShell/7/pwsh.exe"
fi

# detect distro
case "$(awk -F= '/^ID=/{print $2}' /etc/os-release)" in
ubuntu)
    alias bat="batcat"
    alias apt-outdated="sh -c 'apt update && apt list --upgradable'"
    ;;
arch)
    ;;
esac 2>/dev/null
