local -A autoloads=(
    ["compinit -d '$ZSH_COMPDUMP'"]=1
    ["fpath/shell/opts.zsh"]=1
    ["fpath/shell/prompt.zsh"]=1
    ["fpath/shell/bindkey.zsh"]=1
    ["fpath/shell/aliases.zsh"]=1
    ["fpath/util/functions.zsh"]=1
    ["fpath/util/new-tab.zsh"]=1
)

case "$(uname -s)" in
Linux) autoloads[fpath/os/linux.zsh]=1 ;;
Darwin) autoloads[fpath/os/macos.zsh]=1 ;;
esac

for loadname enabled in ${(kv)autoloads}; do
    (( enabled )) || continue
    autoload -Uz "$(cut -d' ' -f1 <<< "$loadname")"
    eval "$loadname"
done

# show hidden files in tab completion
# https://unix.stackexchange.com/a/308322
_comp_options+=(globdots)
