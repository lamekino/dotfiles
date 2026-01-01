# load edit-command-line widget
autoload -Uz edit-command-line
zle -N edit-command-line

bindkey -v # vim bindings
# bindkey -e # emacs/default bash bindings

bindkey "^E" edit-command-line
bindkey "^R" history-incremental-search-backward
