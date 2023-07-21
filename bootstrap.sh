#!/bin/sh

NVIM_GITHUB_URL=https://github.com/neovim/neovim
PACKER_GITHUB_URL=https://github.com/wbthomason/packer.nvim
BREW_INSTALL_URL=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
TMP=$(mktemp -d)

main() {
    dotfiles="
    alacritty
    bin
    dircolors
    nvim
    tmux
    zsh
    "

    link_configs $dotfiles
    create_zshenv
    install_dependencies
    initialize_packer_nvim
}

remove_temp() {
    rm -fr "$TMP"
}
trap remove_tmp 1 2 3 6

report_error() {
    printf "ERROR: %s\n" "$1" 1>&2
    printf "Exiting...\n" 1>&2
    exit 1
}

build_neovim() {
    (git clone "$NVIM_GITHUB_URL" \
        && cd neovim \
        && make CMAKE_BUILD_TYPE=RelWithDebInfo \
    ) || report_error "error in building $NVIM_GITHUB_URL"
}

install_dependencies_linux() {
    old_wd="$PWD"

    PKGS="stow git tmux zsh fzf zoxide"

    # get the first word from /etc/issue
    read -r DISTRO _ < /etc/issue

    cd "$TMP" || report_error "can't cd to $TMP"

    case "$DISTRO" in
    "Arch")
        AUR_URL="https://aur.archlinux.org/neovim-git.git"

        # shellcheck disable=SC2086
        yes | sudo pacman -Syu $PKGS \
            || report_error "error in installing {$PKGS}"

        (git clone "$AUR_URL" \
            && cd neovim-git \
            && makepkg -si \
        ) || report_error "error in building $AUR_URL"
        ;;
    "Ubuntu" | "Debian")
        BUILD_DEPS="ninja-build gettext cmake unzip curl"

        # shellcheck disable=SC2086
        (sudo apt update \
            && sudo apt upgrade -y \
            && sudo apt install -y $BUILD_DEPS $PKGS \
        ) || report_error "error in installing {$BUILD_DEPS $PKGS}"

        (build_neovim \
            && cd neovim/build \
            && cpack -G DEB \
            && sudo dpkg -i nvim-linux64.deb \
        ) || report_error "error in creating .deb for $NVIM_GITHUB_URL"
        ;;
    *) report_error "Unknown linux distro: '$DISTRO'" ;;
    esac

    cd "$old_wd" || report_error "can't cd to $old_wd"
}

# shellcheck disable=SC2317
install_dependencies_macos() {
    report_error "macOS support is not implemented!"

    bash -c "$(curl -fsSL "$BREW_INSTALL_URL")" \
        || report_error "could not install homebrew"

    brew analytics off
}

initialize_packer_nvim() {
    PACKER_DEST="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
    if ! [ -d "$PACKER_DEST" ]; then
        git clone --depth 1 "$PACKER_GITHUB_URL" "$PACKER_DEST" \
            || report_error "failed to clone $PACKER_DEST"
    fi

    nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync' \
        || report_error "failed to initialize packer.nvim"
}

install_dependencies() {
    case "$(uname -s)" in
    "Linux") install_dependencies_linux ;;
    "Darwin") install_dependencies_macos ;;
    *) report_error "Unknown platform: '$KERNEL'"
    esac

    remove_tmp
}

link_configs() {
    for dot in "$@"; do
        echo "installing: $dot"
        stow -t "/home/z0" "$dot"
    done
}

create_zshenv() {
    if ! [ -f ~/.zshenv ]; then
        printf ". ~/.config/zsh/.zshenv\n" > ~/.zshenv
    fi
}
