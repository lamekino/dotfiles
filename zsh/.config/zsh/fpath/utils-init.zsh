# jumps back n dirs if $1 exists 1 otherwise
function ..() {
    if [ -z "$1" ]; then
        cd .. || return
    elif [ "$1" -gt 0 ]; then
        cd $(printf "../%.0s" $(seq 1 "$1")) || return
    fi
}

# uses regex to search history uses the whole argv and basically globs it
function hgrep()  {
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
