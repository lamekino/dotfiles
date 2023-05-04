function up() {
    N="$1"
    [ -z "$N" ] && N=1
    printf "../%.0s" $(seq 1 "$N")
}

# jumps back n dirs if $1 exists 1 otherwise
function ..() {
    cd $(up "$1") || return
}

function pup() {
    pushd $(up "$1") || return
}

# uses regex to search history uses the whole argv and basically globs it
function h()  {
    args=$(sed 's/ /.*/g' <<< ".*$@.*")
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
