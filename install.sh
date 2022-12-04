#!/bin/sh

dotfiles="
alacritty
bin
dircolors
nvim
tmux
zsh
"

for dot in ${dotfiles}; do
    echo "installing: $dot"
    stow -t "$HOME" "$dot"
done

! [ -f ~/.zshenv ] \
    && echo ". ~/.config/zsh/.zshenv" > ~/.zshenv

[ -z "$FRESH_INSTALL" ] && exit

# configure neovim
if ! [ -f ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim

    nvim -u NONE -c \
        "lua dofile('./nvim/.config/nvim/plugin/packer.lua'); \
        require('packer').sync(); \
        print('finished')"
fi
