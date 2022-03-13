#!/bin/bash
set -x

for dot in */; do
    stow -t "$HOME" "$dot"
done
echo ". ~/.config/zsh/.zshenv" > ~/.zshenv
touch ~/.config/zsh/sources

