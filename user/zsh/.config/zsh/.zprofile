export BROWSER="/usr/bin/env firefox"
export EDITOR="/usr/bin/env nvim"
export VISUAL="$EDITOR"
export MANPAGER="nvim -c 'set laststatus=0' +Man!"
export FZF_DEFAULT_COMMAND="find . -type f -and -not -path '*.git/*'"
export FZF_DEFAULT_OPTS="-m --height 40% --border=none"
export BAT_THEME="ansi"
export YDOTOOL_SOCKET="/tmp/.ydotool_socket"
export HOMEBREW_NO_ENV_HINTS=1

# BUG: ~/.local/bin, ~/bin, ghcup dirs, brew's openjdk get added to the *end* of
# $PATH for some reason even if brew and other sources are removed. this might
# just be zsh and macOS being weird.

function { # loads homebrew (this needs to run first)
    local brewroot="/opt/homebrew"
    local openjdk="$brewroot/opt/openjdk"

    if [ -x "$brewroot/bin/brew" ]; then
        eval "$("$brewroot/bin/brew" shellenv zsh)"
    fi

    if [ -d "$openjdk/bin" ]; then
        export PATH="$openjdk/bin:$PATH"
    fi

}

function { # loads zoxide
    [ -n "${commands[zoxide]}" ] && eval "$(zoxide init zsh)"
}

function { # loads dircolors if available
    local use_dircolors=1
    [ -n "${commands[dircolors]}" ] || use_dircolors=0
    [ -f "$XDG_CONFIG_HOME/dircolors" ] || use_dircolors=0
    (( use_dircolors )) && eval "$(dircolors "$XDG_CONFIG_HOME/dircolors")"

}

function { # inits ghcup
    local srcfile="$HOME/.ghcup/env"
    [ -r "$srcfile" ] && source "$srcfile"
}

function { # inits python venv
    local srcfile="$PWD/venv/bin/activate"
    [ -r "$srcfile" ] && source "$srcfile"
}

function { # adds ~/bin to $PATH
    case ":$PATH:" in
    *:"$HOME/bin":*) ;;
    *) export PATH="$HOME/bin:$PATH" ;;
    esac
}

function { # adds ~/.local/bin to $PATH
    case ":$PATH:" in
    *:"$HOME/.local/bin":*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
    esac
}
