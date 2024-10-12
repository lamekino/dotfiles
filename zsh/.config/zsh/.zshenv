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

# Haskell
export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
export CABAL_DIR="$XDG_DATA_HOME/cabal"
export GHCUP_USE_XDG_DIRS=1
export STACK_ROOT="$XDG_DATA_HOME/stack"

# Java (custom jars for javac)
export CLASSPATH="$XDG_DATA_HOME/jars/*:."

# Go
export GOPATH="$XDG_DATA_HOME/go"

# Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Node.js
export npm_config_prefix="$HOME/.local"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

# Misc XDG tweaks
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
# export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# Environment Variables
# TODO: add milliseconds
PS4="%F{2}%D{%s} $PS4%f"
ZDOTDIR=~/.config/zsh
HISTORY_IGNORE='([bf]g *|cd ..*|l[alsh]#( *)#|less *|vim# *|pwd|z *|..*)'
HISTFILE="$XDG_CACHE_HOME/zhistory"
HISTSIZE=50000
SAVEHIST=50000
KEYTIMEOUT=5
fpath=("$XDG_CONFIG_HOME/zsh_fpath" $fpath)

export PATH="\
$CABAL_DIR/bin:\
$GOPATH/bin:\
$CARGO_HOME/bin:\
$HOME/bin:\
$HOME/.local/bin:\
$PATH"
