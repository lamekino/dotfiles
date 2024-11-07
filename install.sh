#!/bin/sh

SKIP_DIRS="
OS-config
"

INSTALLER_ROOT=$(dirname "$(realpath "$0")")

FLAG_HELP="-h"
FLAG_UNINSTALL="-x"

MSG_INSTALL="installing"
MSG_UNINSTALL="uninstalling"

CMD_INSTALL="stow -d '$INSTALLER_ROOT' -t '$HOME'"
CMD_UNINSTALL="$CMD_INSTALL -D"

case "$1" in
"$FLAG_HELP")
    printf "%s: installs dotfiles\n" "$0"
    printf "    %s    show this help\n" "$FLAG_HELP"
    printf "    %s    uninstall config (remove symlinks)\n" "$FLAG_UNINSTALL"
    printf "requires 'stow' to work. run w/o args to install to \$HOME.\n"
    exit 0
    ;;
"$FLAG_UNINSTALL")
    msg="$MSG_UNINSTALL"
    alias stow_cmd="$CMD_UNINSTALL"
    ;;
"")
    msg="$MSG_INSTALL"
    alias stow_cmd="$CMD_INSTALL"
    ;;
*)
    printf "unknown option: %s\n" "$1"
    printf "\n"
    printf "run \"%s %s\" to view help\n" "$0" "$FLAG_HELP"
    exit 1
    ;;
esac

for dot in "$INSTALLER_ROOT"/*/; do
    config_name="$(basename "$dot")"

    if ! (echo "$SKIP_DIRS" | grep -q "^$config_name$"); then
        printf "%s: %s\n" "$msg" "$config_name"
        stow_cmd "$config_name"
    fi
done

if [ "$msg" = "$MSG_INSTALL" ] && ! [ -f ~/.zshenv ]; then
    printf ". ~/.config/zsh/.zshenv\n" > ~/.zshenv
fi
