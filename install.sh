#!/bin/bash

skip_dl=0
if [ -n $1 ]; then
	skip_dl=1
fi

files=()
for i in *; do
	case $i in
		".*" | "install.sh")
			continue
			;;
		*)
			files+=($i)
			;;
	esac
done

cmd=
select opt in "link" "copy" "remove"; do
	case $opt in
		"link")
			cmd="ln -srvi"
			;;
		"copy")
			cmd="cp -vir"
			;;
		"remove")
			for i in ${files[@]}; do
				rm -ri ~/.${i}
			done
			rm -rfi ~/.tmux ~/.vim
			exit 0
			;;
		*)
			echo $opt
			echo "Invaild option" 1>&2
			exit 1
			;;
	esac
	break
done

for i in ${files[@]}; do
	$cmd $i ~/.${i}
done

# download any remote dependencies
if [ $skip_dl -ne 1 ]; then
	# assume already downloaded if directory exists
	if ! [ -d ~/.vim ]; then
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		echo -e "\033[0;10m -> run :PlugInstall to install vim plugins\033[0m"
	fi

	if ! [ -d ~/.tmux ]; then
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		echo "\033[0;10m -> type <prefix>-I to install tmux plugins\033[0m"
	fi
fi
