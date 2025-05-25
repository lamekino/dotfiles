[ -n "${DEBUG+1}" ] && zmodload "zsh/zprof" && set -xe

autoload -Uz my-zshrc && my-zshrc

[ -n "${DEBUG+1}" ] && zprof || return 0
