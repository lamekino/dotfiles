## Environment Variables ##
HISTORY_IGNORE='([bf]g *|cd *|l[alsh]#( *)#|less *|vim# *|pwd)'
HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=50000

export EDITOR="/usr/bin/env vim"
export VISUAL="/usr/bin/env vim"
export GOPATH="$HOME/.go"
export PAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma nornu' -\""
export BAT_PAGER="less"
export FZF_DEFAULT_COMMAND="find ."
export FZF_DEFAULT_OPTS="\
	--height 40% --layout=reverse --border --preview \
	'bat --color=always --style plain --line-range :16 {}'"
export PATH="\
$PATH:\
.:\
$HOME/bin:\
$HOME/.local/bin:\
$GOPATH/bin:\
$HOME/node_modules/.bin"
