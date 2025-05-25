# vim:ft=zsh

# autoloaded scripts to be run
local -a autoloads=(
    "prompt.zsh"
    "functions.zsh"
    "opts.zsh"
    "aliases.zsh"
)

# files to be sourced into zsh
local -a sources=("$HOME/.ghcup/env" "$PWD/venv/bin/activate")

# utils which need to be eval'd to initialize
local -a evals=()

if (( ${+commands[zoxide]} )); then
    evals+=("$(zoxide init zsh)")
fi

if [ -f "$XDG_CONFIG_HOME/dircolors" ]; then
    evals+=("$(dircolors "$XDG_CONFIG_HOME/dircolors")")
fi

for e in "${evals[@]}"; do
    eval "$e"
done

for s in "${sources[@]}"; do
    if [ -f "$s" ]; then
        source "$s"
    fi
done

for func in "${autoloads[@]}"; do
    autoload -Uz "$func"
    "$func"
done
