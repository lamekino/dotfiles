# environment
export PATH="$PATH"
export BROWSER="/usr/bin/env firefox"
export EDITOR="/usr/bin/env nvim"
export VISUAL="$EDITOR"
export MANPAGER='nvim -c "set laststatus=0" +Man!'

# homebrew (NOTE: this inits the $PATH on macOS and needs to be set for zoxide,
# etc to be loaded AFTER in the zsh config)
export HOMEBREW_NO_ENV_HINTS=1
HOMEBREW_ROOT="/opt/homebrew"

if [ -d "$HOMEBREW_ROOT/opt/openjdk/bin" ]; then
    export PATH="$HOMEBREW_ROOT/opt/openjdk/bin:$PATH"
fi

if [ -x "$HOMEBREW_ROOT/bin/brew" ]; then
    eval "$("$HOMEBREW_ROOT/bin/brew" shellenv zsh)"
fi

# zoxide
if [ -n "${commands[zoxide]}" ]; then
    eval "$(zoxide init zsh)"
fi

# dircolors
if [ -n "${commands[dircolors]}" ] && [ -f "$XDG_CONFIG_HOME/dircolors" ]; then
    eval "$(dircolors "$XDG_CONFIG_HOME/dircolors")"
fi

# ghcup
if [ -r "$HOME/.ghcup/env" ]; then
    source "$HOME/.ghcup/env"
fi

# python venv
if [ -r "$PWD/venv/bin/activate" ]; then
    source "$PWD/venv/bin/activate"
fi

# my stuff
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS="-m --height 40% --border=none"

# bat
export BAT_THEME="ansi"

# ydotool
export YDOTOOL_SOCKET="/tmp/.ydotool_socket"
