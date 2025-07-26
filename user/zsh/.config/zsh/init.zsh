if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

local -a autoloads=(
    "compinit -d '$ZSH_COMPDUMP'"
    "shell/opts.zsh"
    "shell/prompt.zsh"
    "shell/bindkey.zsh"
    "shell/aliases.zsh"
    "util/functions.zsh"
    "util/new-tab.zsh"
)

case "$(uname -s)" in
Linux) autoloads+="os/linux.zsh" ;;
Darwin) autoloads+="os/macos.zsh" ;;
esac

for funcname in "${autoloads[@]}"; do
    autoload -Uz "$(cut -d' ' -f1 <<< "$funcname")"
    eval "$funcname"
done

# show hidden files in tab completion
# https://unix.stackexchange.com/a/308322
_comp_options+=(globdots)
