# vim:ft=zsh

# start tab completion
autoload -Uz compinit
compinit

# load edit-command-line widget
autoload -Uz edit-command-line
zle -N edit-command-line

setopt HIST_IGNORE_ALL_DUPS # remove duplicate history entries
setopt INTERACTIVE_COMMENTS # enable comments in shell
setopt COMPLETE_ALIASES # don't expand aliases w/ completion
setopt PROMPT_SUBST # expand $(), $(()), etc w/ completion

bindkey -v # use vim bindings
bindkey "^R" history-incremental-search-backward
bindkey "^E" edit-command-line # ?

zstyle ":completion:*" menu select # use a menu selector
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # use colorful menu
zstyle ":completion:*" matcher-list "" \
    "m:{a-zA-Z}={A-Za-z}" "r:|=*" "l:|=* r:|=*" # case insensitive completion
