#!/bin/sh

set -eu

INSTALLER_DIR="$(dirname "$(realpath "$0")")/user"
CMD_FLAGS="-v -d '$INSTALLER_DIR' -t '$HOME'"

COLOR_ARROW=32
COLOR_MSG=34
COLOR_CMD=33

FLAG_HELP="-h"
FLAG_INSTALL="-i"
FLAG_UNINSTALL="-x"

MSG_INSTALL="Installing"
MSG_UNINSTALL="Uninstalling"

install_msg() {
    printf "\033[%sm==> \033[1;%sm%s %s...\033[0m\n" \
        "$COLOR_ARROW" "$COLOR_MSG" "$1" "$2"
}

run_stow() {
    printf "\033[%sm" "$COLOR_CMD"
    sh -xc "stow $1 $2"
    printf "\033[0m"
}

case "${1-$FLAG_INSTALL}" in
"$FLAG_HELP")
    printf "%s: installs dotfiles\n" "$0"
    printf "  %s  show this help.\n" "$FLAG_HELP"
    printf "  %s  install config. same as running w/o args.\n" "$FLAG_INSTALL"
    printf "  %s  uninstall config (remove symlinks).\n" "$FLAG_UNINSTALL"
    printf "requires 'stow' to work."
    exit 0
    ;;
"$FLAG_UNINSTALL")
    msg="$MSG_UNINSTALL"
    CMD_FLAGS="-D $CMD_FLAGS"
    ;;
"$FLAG_INSTALL")
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

    install_msg "$msg" "$config_name"
    run_stow "$CMD_FLAGS" "$config_name"
done
