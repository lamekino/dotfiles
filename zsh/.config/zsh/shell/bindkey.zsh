# initialize tab completion
autoload -Uz compinit
compinit

# load edit-command-line widget
autoload -Uz edit-command-line
zle -N edit-command-line

bindkey -v # use vim bindings
bindkey "^E" edit-command-line # change key?
bindkey "^R" history-incremental-search-backward

