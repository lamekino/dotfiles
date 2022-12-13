function up() {
    N="$1"
    [ -z "$N" ] && N=1
    printf "../%.0s" $(seq 1 "$N")
}

# jumps back n dirs if $1 exists 1 otherwise
function ..() {
    cd $(up "$1") || return
}

function pp() { # push to parent ;)
    pushd $(up "$1") || return
}

function bak() {
    mv "${1}"{,.bak}
}

function unbak() {
    mv "${1}"{.bak,}
}

# uses regex to search history uses the whole argv and basically globs it
function h()  {
    args=$(sed 's/ /.*/g' <<< ".*$@.*")
    history 1 | grep -E "$args"
}

# mkdir and cd into it
function md() {
    mkdir -p "$1" && builtin cd "$1"
}

# pushd using z
function pz() {
    builtin pushd $(zoxide query "$@")
}
