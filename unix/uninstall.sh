#!/bin/sh

configs_dir=$(dirname "$(realpath "$0")")

for dot in "$configs_dir"/*/; do
    echo "uninstalling: $dot"
    stow -D -t "$HOME" "$(basename "$dot")"
done
