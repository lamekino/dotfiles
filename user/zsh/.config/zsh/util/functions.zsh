function up() {
    N="$1"
    [ -z "$N" ] && N=1
    printf "../%.0s" $(seq 1 "$N")
}

# jumps back n dirs if $1 exists 1 otherwise
function ..() {
    cd $(up "$1") &>/dev/null || return
}

# uses regex to search history uses the whole argv and basically globs it
function h()  {
    args=$(sed 's/ / .*/g' <<< ".*$@.*")
    history 1 | grep -E "$args"
}

alias hgrep="h"

# mkdir and cd into it
function md() {
    mkdir -p "$1" && builtin cd "$1"
}

# pushd using z
function pz() {
    builtin pushd $(zoxide query "$@")
}

# pretty prints $PATH
function ppath() {
    paths=$(sed 's/:/\n/g' <<< "$PATH")
    printf "%s\n" $paths
}

function stalk() {
    echo "$1" | entr -c "$1"
}

alias ta="tmux a"

function tada {
    if tmux ls 2>/dev/null | grep -q home; then
        tmux a -t home
    else
        tmux new -s home -c "$HOME"
    fi
}
