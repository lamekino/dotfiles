PS4="%F{2}%D %* $PS4%f"
HISTORY_IGNORE='([bf]g *|cd ..*|l[alsh]#( *)#|less *|vim# *|pwd|z *|..*)'
HISTFILE="$XDG_CACHE_HOME/zhistory"
HISTSIZE=50000
SAVEHIST=50000
KEYTIMEOUT=5

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export BROWSER="/usr/bin/env firefox"
export EDITOR="/usr/bin/env nvim"
export VISUAL="$EDITOR"
export MANPAGER='nvim -c "set laststatus=0" +Man!'

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS="-m --height 40% --border=none"

export BAT_THEME="ansi"

export YDOTOOL_SOCKET="/tmp/.ydotool_socket"

export HOMEBREW_ROOT="/opt/homebrew"

# include homebrew files
if [ -d "$HOMEBREW_ROOT" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
