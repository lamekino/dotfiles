# load edit-command-line widget
autoload -Uz edit-command-line
zle -N edit-command-line

# bindkey -v # vim bindings (makes bad muscle memory working on servers)
bindkey -e # emacs/default bash bindings

bindkey "^X^E" edit-command-line
bindkey "^R" history-incremental-search-backward
