[ -n "${DEBUG+1}" ] && zmodload "zsh/zprof" && set -xe

KEYTIMEOUT=5
PS4="%F{2}%D %* $PS4%f"
HISTSIZE=50000
SAVEHIST=50000
HISTORY_IGNORE='([bf]g *|cd ..*|l[alsh]#( *)#|less *|vim# *|pwd|z *|..*)'
HISTFILE="$XDG_CACHE_HOME/zhistory"
ZSH_COMPDUMP="$XDG_CACHE_HOME/zcompdump"

fpath=("$ZDOTDIR" $fpath)
autoload -Uz init.zsh && init.zsh

[ -n "${DEBUG+1}" ] && zprof || return 0
