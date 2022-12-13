function prompt-color() {
    local color="$1"
    local string="$2"
    echo -n "%F{$color}$string%f"
}

function git-prompt() {
    local branch=$(git branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        local unstaged=$(git status --short | wc -l)

        if [ $unstaged -eq 0 ]; then
            echo "$(prompt-color 10 "@$branch"):"
        else
            echo "$(prompt-color 9 "@$branch+$unstaged"):"
        fi
    fi
}

function precmd-prompt() {
    local dir="$(prompt-color 6 '%~')"
    local err="$(prompt-color 1 '%?')"
    local job="$(prompt-color 3 '%%%j')"
    local git="$(git-prompt)"

    _PROMPT="%(1j.${job} .)%(?..${err} )${git}${dir}"
}


function zle-line-init zle-keymap-select {
    local norm="$(prompt-color 5 '>')"
    local ins="$(prompt-color 15 '%#')"

    case $KEYMAP in
        vicmd)      PROMPT="${_PROMPT}${norm} " ;;
        viins|main) PROMPT="${_PROMPT}${ins} " ;;
    esac
    zle reset-prompt
}

precmd_functions+=(precmd-prompt)
zle -N zle-line-init
zle -N zle-keymap-select
