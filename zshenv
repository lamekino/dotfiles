## Environment Variables ##
HISTORY_IGNORE='([bf]g *|cd *|l[alsh]#( *)#|less *|vim# *|pwd|z *|..*)'
HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=50000
KEYTIMEOUT=5

export PATH="\
$PATH:\
$HOME/bin:\
$HOME/.local/bin:\
$GOPATH/bin:\
$HOME/node_modules/.bin"

export XDG_CONFIG_HOME="$HOME/.config"
export BROWSER="/usr/bin/env firefox"
export EDITOR="/usr/bin/env vim"
export VISUAL="/usr/bin/env vim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export GOPATH="$HOME/.go"
export FZF_DEFAULT_COMMAND="find ."
export FZF_DEFAULT_OPTS="\
    -m --height 40% --layout=reverse --border=sharp --preview \
    'bat --color=always --style plain --line-range :16 {}'"
