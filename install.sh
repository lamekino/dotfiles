#!/bin/sh

[ -z "$1" ]       && cmd="ln -svi"
[ "$1" = "link" ] && cmd="ln -svi"
[ "$1" = "copy" ] && cmd="cp -rvi"

for i in *; do
	case "$i" in
		"install.sh")
			continue
			;;
		*)
			eval "$cmd $PWD/$i $HOME/.$i"
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
