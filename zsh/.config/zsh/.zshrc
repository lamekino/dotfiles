[ -n "${DEBUG+1}" ] && zmodload "zsh/zprof" && set -xe

fpath=("$ZDOTDIR" $fpath)
autoload -Uz init.zsh && init.zsh

[ -n "${DEBUG+1}" ] && zprof || return 0
