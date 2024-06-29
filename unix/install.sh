#!/bin/sh

configs_dir=$(dirname "$(realpath "$0")")

for dot in "$configs_dir"/*/; do
    echo "installing: $dot"
    stow -t "$HOME" "$(basename $dot)"
done

if ! [ -f ~/.zshenv ]; then
    printf ". ~/.config/zsh/.zshenv\n" > ~/.zshenv
fi
