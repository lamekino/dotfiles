# fixes the issue that nvim sources the packer config before downloading
# packages. also downloads packer.nvim
#!/bin/sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim -u NONE -c \
    "lua dofile('./nvim/.config/nvim/plugin/packer.lua'); \
    require('packer').sync(); \
    print('finished')"

