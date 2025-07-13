#!/bin/sh

INSTALLER_DIR="$(dirname "$(realpath "$0")")/user"
CMD_INSTALL="stow -v -d '$INSTALLER_DIR' -t '$HOME'"

COLOR_ARROW=32
COLOR_MSG=34
COLOR_CMD=33

FLAG_HELP="-h"
FLAG_UNINSTALL="-x"

MSG_INSTALL="Installing"
MSG_UNINSTALL="Uninstalling"

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
    CMD_INSTALL="$CMD_INSTALL -D"
    ;;
"")
    msg="$MSG_INSTALL"
    ;;
*)
    printf "unknown option: %s\n" "$1"
    printf "\n"
    printf "run \"%s %s\" to view help\n" "$0" "$FLAG_HELP"
    exit 1
    ;;
esac

for dot in "$INSTALLER_DIR"/*/; do
    config_name="$(basename "$dot")"

    if ! (echo "$SKIP_DIRS" | grep -q "^$config_name$"); then
        printf "\033[%sm==> \033[1;%sm%s %s...\033[0m\n" \
            "$COLOR_ARROW" "$COLOR_MSG" "$msg" "$config_name"

        printf "\033[%sm" "$COLOR_CMD"
        sh -xc "$CMD_INSTALL $config_name"
        printf "\033[0m"
    fi
done
