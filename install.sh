#!/bin/sh
# yes, i did everything to make this POSIX sh
# and yes this is very over engineered

# creates the file which find will write to
# no process subsitution or mapfile! this is
# *beautiful* posix shell
tmpfile=$(mktemp)
hook() { rm -fr "$tmpfile"; }
trap hook EXIT

# -l: link dotfiles (default)
# -c: copy dotfiles
# -d: enable downloads
create() { ln -sv "$1" "$2"; }
downloads=0
while getopts "lcd" arg; do
    case "$arg" in
        c) create() { ln -sv  "$1" "$2"; } ;;
        l) create() { cp -v   "$1" "$2"; } ;;
        d) downloads=1 ;;
        ?) echo "invalid flag $arg"; exit 1 ;;
    esac
done

# gets all the necessary files from the source directory
find "$PWD" \
    -mindepth 1 \
    -not -path "$PWD/.*" \
    -and -not -name "install*" \
    > "$tmpfile"

# reads the files, and either creates the dot files
# or creates the parent directory
while IFS= read -r REPLY; do
    src="$REPLY"
    dest=$(echo "$src" | sed "s|^$PWD\/|$HOME\/\.|g")
    echo $dest
    if [ ! -e "$dest" ]; then
        [ -d "$src" ] && mkdir -pv "$dest"
        [ -f "$src" ] && create "$src" "$dest"
    fi
done < "$tmpfile"

# download files if enabled
if [ $downloads -eq 1 ]; then
    # vim plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInsall +qall
    # tmux plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
