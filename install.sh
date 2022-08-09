#!/bin/sh

dotfiles="
alacritty
bin
nvim
tmux
zsh
"

for dot in ${dotfiles}; do
    echo "installing: $dot"
    stow -t "$HOME" "$dot"
done
echo ". ~/.config/zsh/.zshenv" > ~/.zshenv
touch ~/.config/zsh/sources

