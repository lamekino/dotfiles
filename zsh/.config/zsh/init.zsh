# autoloaded scripts to be run
local -a autoloads=(
    "shell/opts.zsh"
    "shell/prompt.zsh"
    "shell/bindkey.zsh"
    "util/aliases.zsh"
    "util/functions.zsh"
)

# files to be sourced into zsh
local -a sources=("$HOME/.ghcup/env" "$PWD/venv/bin/activate")

# utils which need to be eval'd to initialize
local -a evals=()

# include os-specific files
case $(uname -s) in
Linux) autoloads+="os/linux.zsh" ;;
Darwin) autoloads+="os/macos.zsh" ;;
esac

# initizalize zoxide
if (( ${+commands[zoxide]} )); then
    evals+=("$(zoxide init zsh)")
fi

# initialize dircolors
if [ -f "$XDG_CONFIG_HOME/dircolors" ]; then
    evals+=("$(dircolors "$XDG_CONFIG_HOME/dircolors")")
fi

# loop through all arrays and apply their operation
for s in "${sources[@]}"; do
    if [ -f "$s" ]; then
        source "$s"
    fi
done

for func in "${autoloads[@]}"; do
    autoload -Uz "$func"
    "$func"
done

for e in "${evals[@]}"; do
    eval "$e"
done
