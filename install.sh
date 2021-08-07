#!/bin/sh

# FIXME: this only works with gnu tools
[ -z "$1" ]       && cmd="ln -svi"
[ "$1" = "link" ] && cmd="ln -svi"
[ "$1" = "copy" ] && cmd="cp -rvi"

for dir in config/*; do
    eval "$cmd $dir $HOME/.config/$(basename $dir)"
done

for file in *; do
    case "$i" in
        "install.sh")
            continue
            ;;
        *)
            eval "$cmd $PWD/$file $HOME/.$file"
            ;;
    esac
done

# download plugins
[ ! -f ~/.vim/autoload/plug.vim ] && \
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
        vim +PlugInsall +qall
[ ! -d ~/.tmux ] && \
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
