[ -n "${DEBUG+1}" ] && zmodload "zsh/zprof" && set -xe

autoload -Uz init.zsh && init.zsh

[ -n "${DEBUG+1}" ] && zprof || return 0
