export BROWSER="/usr/bin/env firefox"
export EDITOR="/usr/bin/env nvim"
export VISUAL="$EDITOR"

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS="-m --height 40% --border=none"

export BAT_THEME="ansi"

export MANPAGER='nvim -c "set laststatus=0" +Man!'

# XDG Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Environment Variables
PS4="%F{2}%D{%s} $PS4%f"
ZDOTDIR=~/.config/zsh
HISTORY_IGNORE='([bf]g *|cd ..*|l[alsh]#( *)#|less *|vim# *|pwd|z *|..*)'
HISTFILE="$XDG_CACHE_HOME/zhistory"
HISTSIZE=50000
SAVEHIST=50000
KEYTIMEOUT=5
fpath=("$XDG_CONFIG_HOME/zsh_fpath" $fpath)

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
