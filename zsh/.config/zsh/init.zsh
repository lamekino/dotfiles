#
# autoloaded scripts to be run
#
local -a autoloads=(
    "compinit" # for tab completion
    "shell/opts.zsh"
    "shell/prompt.zsh"
    "shell/bindkey.zsh"
    "util/aliases.zsh"
    "util/functions.zsh"
    "util/new-tab.zsh"
)

# include os-specific files
case $(uname -s) in
Linux) autoloads+="os/linux.zsh" ;;
Darwin) autoloads+="os/macos.zsh" ;;
esac

# load and run functions
for func in "${autoloads[@]}"; do
    autoload -Uz "$func"
    "$func"
done

#
# files to be sourced into zsh
#
local -a sources=("$HOME/.ghcup/env" "$PWD/venv/bin/activate")
for s in "${sources[@]}"; do
    if [ -f "$s" ]; then
        source "$s"
    fi
done

#
# utils which need to be eval'd to initialize
#
local -a evals=()

# initizalize zoxide
if (( ${+commands[zoxide]} )); then
    evals+=("$(zoxide init zsh)")
fi

# initialize dircolors
if [ -f "$XDG_CONFIG_HOME/dircolors" ]; then
    evals+=("$(dircolors "$XDG_CONFIG_HOME/dircolors")")
fi

for e in "${evals[@]}"; do
    eval "$e"
done
