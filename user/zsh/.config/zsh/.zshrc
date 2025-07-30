[ -n "${DEBUG+1}" ] && zmodload "zsh/zprof" && set -xuo pipefail

KEYTIMEOUT=5
HISTSIZE=50000
SAVEHIST=50000
HISTORY_IGNORE='([bf]g *|cd ..*|l[alsh]#( *)#|less *|vim# *|pwd|z *|..*)'
HISTFILE="$XDG_CACHE_HOME/zhistory"
ZSH_COMPDUMP="$XDG_CACHE_HOME/zcompdump"
ZSH_COMPCACHE="$XDG_CACHE_HOME/zcompcache"

fpath=("$ZDOTDIR" $fpath)
autoload -Uz init.zsh && init.zsh
fpath=(${fpath[@]:1})

[ -n "${DEBUG+1}" ] && zprof || return 0
