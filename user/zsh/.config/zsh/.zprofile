export BROWSER="/usr/bin/env firefox"
export EDITOR="/usr/bin/env nvim"
export VISUAL="$EDITOR"
export MANPAGER="nvim -c 'set laststatus=0' +Man!"
export FZF_DEFAULT_COMMAND="find . -type f -and -not -path '*.git/*'"
export FZF_DEFAULT_OPTS="-m --height 40% --border=none"
export BAT_THEME="ansi"
export YDOTOOL_SOCKET="/tmp/.ydotool_socket"
export HOMEBREW_NO_ENV_HINTS=1

function { # loads homebrew (needs to run first)
    local brewroot="/opt/homebrew"
    local openjdk="$brewroot/opt/openjdk"

    if [ -d "$openjdk/bin" ]; then
        export PATH="$openjdk/bin:$PATH"
    fi

    if [ -x "$brewroot/bin/brew" ]; then
        eval "$("$brewroot/bin/brew" shellenv zsh)"
    fi
}

function { # loads zoxide
    [ -n "${commands[zoxide]}" ] && eval "$(zoxide init zsh)"
}

function { # loads dircolors if available
    local use_dircolors=1
    [ -n "${commands[dircolors]}" ] || use_dircolors=0
    [ -f "$XDG_CONFIG_HOME/dircolors" ] || use_dircolors=0

    if (( use_dircolors )); then
        eval "$(dircolors "$XDG_CONFIG_HOME/dircolors")"
    fi

}

function { # inits ghcup
    local ghcup="$HOME/.ghcup"
    [ -r "$ghcup/env" ] && source "$ghcup/env"
}

function { # inits python venv
    local venv="$PWD/venv"
    [ -r "$venv/bin/activate" ] && source "$venv/bin/activate"
}

function { # prepends dirs to $PATH
    local -a prepend=("$HOME/bin" "$HOME/.local/bin")
    local cursor=${#prepend}

    while (( cursor-- )); do
        case "$PATH" in
        *"${prepend[cursor]}"*) ;;
        *) export PATH="${prepend[cursor]}:$PATH" ;;
        esac
    done
}
