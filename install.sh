#!/usr/bin/env zsh
set -x

PROGRAMS=(alacritty bin nvim zsh tmux)

for dot in ${PROGRAMS[@]}; do
    stow -t "$HOME" "$dot"
done
echo ". ~/.config/zsh/.zshenv" > ~/.zshenv
touch ~/.config/zsh/sources

