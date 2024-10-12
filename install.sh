#!/bin/sh

DOTFILE_DIR=$(dirname "$(realpath "$0")")

INSTALL_MSG="installing"
UNINSTALL_MSG="uninstalling"

CMD_INSTALL="stow -d '$DOTFILE_DIR' -t '$HOME'"
CMD_UNINSTALL="$CMD_INSTALL -D"

FLAG_HELP="-h"
FLAG_UNINSTALL="-x"

case "$1" in
"$FLAG_HELP")
    printf "%s: installs dotfiles\n" "$0"
    printf "    %s    show this help\n" "$FLAG_HELP"
    printf "    %s    uninstall config (remove symlinks)\n" "$FLAG_UNINSTALL"
    printf "requires \`stow\` to work. run w/o args to install to \$HOME.\n"
    exit 0
    ;;
"$FLAG_UNINSTALL")
    msg="$UNINSTALL_MSG"
    alias stow_cmd="$CMD_UNINSTALL"
    ;;
*)
    msg="$INSTALL_MSG"
    alias stow_cmd="$CMD_INSTALL"
    ;;
esac

for dot in "$DOTFILE_DIR"/*/; do
    printf "%s: %s\n" "$msg" "$dot"
    stow_cmd "$(basename "$dot")"
done

if [ "$msg" = "$INSTALL_MSG" ] && ! [ -f ~/.zshenv ]; then
    printf ". ~/.config/zsh/.zshenv\n" > ~/.zshenv
fi
