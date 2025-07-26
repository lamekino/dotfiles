[ -n "${DEBUG+1}" ] && zmodload "zsh/zprof" && set -xe

# environment
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export BROWSER="/usr/bin/env firefox"
export EDITOR="/usr/bin/env nvim"
export VISUAL="$EDITOR"
export MANPAGER='nvim -c "set laststatus=0" +Man!'

# fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS="-m --height 40% --border=none"

# bat
export BAT_THEME="ansi"

# ydotool
export YDOTOOL_SOCKET="/tmp/.ydotool_socket"

# homebrew
export HOMEBREW_NO_ENV_HINTS=1

HOMEBREW_ROOT="/opt/homebrew"

if [ -x "$HOMEBREW_ROOT/bin/brew" ]; then
    eval "$("$HOMEBREW_ROOT"/bin/brew shellenv)"
fi

# ghcup
if [ -r "$HOME/.ghcup/env" ]; then
    source "$HOME/.ghcup/env"
fi

# python venv
if [ -r "$PWD/venv/bin/activate" ]; then
    source "$PWD/venv/bin/activate"
fi

[ -n "${DEBUG+1}" ] && zprof || return 0
