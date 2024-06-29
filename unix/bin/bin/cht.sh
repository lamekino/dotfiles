#!/bin/sh

alias default_pager="less -R"
alias fuzzy_find="fzf --no-preview"

usage() {
    script_name="$(basename "$0")"
    echo "interactive cht.sh
    $script_name <query>     - open query
    $script_name             - search cht.sh with fzf
    $script_name -h          - view this help" 1>&2
}

request_page() {
    curl -s "cht.sh/$1"
}

request_index() {
    request_page ":list"
}

pager() {
    if [ -z "$PAGER" ]
        then default_pager
        else "$PAGER"
    fi
}

view_page() {
    if [ -n "$1" ]
        then request_page "$1" | pager
        else exit 1
    fi
}

case "$1" in
-h) usage ;;
"") view_page "$(request_index | fuzzy_find)";;
*) view_page "$1" ;;
esac
