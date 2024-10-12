#!/bin/sh

configs_dir=$(dirname "$(realpath "$0")")

alias stow_install="stow -d '$configs_dir' -t '$HOME'"

for dot in "$configs_dir"/*/; do
    echo "installing: $dot"
    stow_install "$(basename $dot)"
done

if ! [ -f ~/.zshenv ]; then
    printf ". ~/.config/zsh/.zshenv\n" > ~/.zshenv
fi
