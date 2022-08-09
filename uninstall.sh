#!/bin/sh
set -x

dotfiles="
alacritty
bin
nvim
tmux
zsh
"

for dot in $dotfiles; do
    echo "removing: $dot"
    stow -D -t "$HOME" "$dot"
done
