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
alias hd="hexdump -C"
alias stop="kill -STOP"
alias youtube-dl="yt-dlp" # rip
alias Z="zoxide"
alias fs="dfc -T -p /dev 2>/dev/null"
alias neofetch="fastfetch --config neofetch" # rip ;-;
alias vi="nvim -u NONE"

# wezterm
alias wez-rename="wezterm cli set-tab-title"

# zsh config
alias zsh-debug="time DEBUG=1 zsh -i -c exit"
alias zsh-rc="$EDITOR $ZDOTDIR/.zshrc"
alias zsh-env="$EDITOR $ZDOTDIR/.zshenv"
alias zsh-aliases="$EDITOR $ZDOTDIR/aliases.zsh"
alias zsh-functions="$EDITOR $ZDOTDIR/functions.zsh"
alias zsh-init="$EDITOR $ZDOTDIR/init.zsh"
alias zsh-opts="$EDITOR $ZDOTDIR/opts.zsh"
alias zsh-prompt="$EDITOR $ZDOTDIR/prompt.zsh"

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
