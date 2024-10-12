#!/bin/sh

configs_dir=$(dirname "$(realpath "$0")")

alias stow_install="stow -d '$configs_dir' -t '$HOME'"

for dot in "$configs_dir"/*/; do
    echo "uninstalling: $dot"
    stow_install -D "$(basename "$dot")"
done
