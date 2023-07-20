#!/bin/sh

set -x
. ./bootstrap.sh
[ "$1" = "-b" ] && alias use_bootstrap=true || alias use_bootstrap=false

dotfiles="
alacritty
bin
dircolors
nvim
tmux
zsh
"

if use_bootstrap; then
    bootstrap
fi

for dot in $dotfiles; do
    echo "installing: $dot"
    stow -t "/home/z0" "$dot"
done

if ! [ -f ~/.zshenv ]; then
    printf ". ~/.config/zsh/.zshenv\n" > ~/.zshenv
fi

if use_bootstrap; then
    initialize_packer_nvim
fi
