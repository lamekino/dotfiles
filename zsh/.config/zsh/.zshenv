# xdg definitions
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# shell
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
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
export HOMEBREW_ROOT="/opt/homebrew"

[ -d "$HOMEBREW_ROOT" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# disbale $ZDOTDIR/.zsh_session on macOS
# https://apple.stackexchange.com/a/427568
SHELL_SESSIONS_DISABLE=1
