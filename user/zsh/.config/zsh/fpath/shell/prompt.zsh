PROMPT= # if set, this will be above the first shown line (scroll up)

PROMPT_SEPARATOR=":" # separates elements added with prompt-put-widget

typeset -gA PROMPT_SIGNS # holds the current prompt symbols
typeset -gA PROMPT_SIGNS_INIT=( # default/reset symbols
    ["SIGN_MODS"]="&"
    ["SIGN_DIRS"]="~"
    ["SIGN_JOBS"]="%%"
    ["SIGN_ERROR"]="!"
    ["SIGN_GIT"]="@"
    ["SIGN_VIM_NORMAL"]="|"
    ["SIGN_VIM_INSERT"]="%#"
)

typeset -gA PROMPT_COLORS # holds the current prompt colors
typeset -gA PROMPT_COLORS_INIT=( # default/reset colors
    ["COLOR_ERROR"]=1
    ["COLOR_JOBS"]=12
    ["COLOR_MOD_VENV"]=14
    ["COLOR_DIRS"]=5
    ["COLOR_GIT_CLEAN"]=10
    ["COLOR_GIT_DIRTY"]=9
    ["COLOR_PWD"]=3
    ["COLOR_TIP"]=15
)

# prompt info toggles
[ -r "${VIRTUAL_ENV-}" ] && PROMPT_HAS_VENV=1

#
# internal functions
#

function prompt-put-text {
    typeset -g PROMPT_COLORS
    PROMPT="$PROMPT%F{${PROMPT_COLORS[$1]}}$2%f$3"
}

function prompt-put-widget {
    typeset -g PROMPT_COLORS
    PROMPT="$PROMPT%F{${PROMPT_COLORS[$1]}}$2%f$PROMPT_SEPARATOR"
}

function prompt-add-jobs {
    prompt-put-text COLOR_JOBS \
        "%(1j.${PROMPT_SIGNS[SIGN_JOBS]}%j.)" \
        "%(1j.$PROMPT_SEPARATOR.)"
}

function prompt-add-error {
    prompt-put-text COLOR_ERROR \
        "%(?..${PROMPT_SIGNS[SIGN_ERROR]}%?)" \
        "%(?..$PROMPT_SEPARATOR)"
}

function prompt-add-tip {
    local tip="${PROMPT_SIGNS[SIGN_VIM_INSERT]}"
    [ "$KEYMAP" = "vicmd" ] && tip="${PROMPT_SIGNS[SIGN_VIM_NORMAL]}"

    prompt-put-text COLOR_PWD "%~" ""
    prompt-put-text COLOR_TIP "$tip" " "
}

function prompt-add-dirs {
    local dirs_count="$(dirs -v | wc -l | xargs)"
    (( dirs_count < 2 )) && return 1

    prompt-put-widget COLOR_DIRS "${PROMPT_SIGNS[SIGN_DIRS]}${dirs_count}"
}

function prompt-add-git {
    local git_branch="$(git branch --show-current 2>/dev/null)"
    [ -z "${git_branch}" ] && return 1

    local git_changes="$(git status --short 2>/dev/null | wc -l | xargs)"
    local git_color=COLOR_GIT_CLEAN
    local git_str="${PROMPT_SIGNS[SIGN_GIT]}${git_branch}"

    if (( git_changes > 0 )); then
        git_color=COLOR_GIT_DIRTY
        git_str="${git_str}+${git_changes}"
    fi

    prompt-put-widget "$git_color" "$git_str"
}

function prompt-add-mod {
    local cond="$1" name="$2" color="$3"
    (( cond )) || return 1

    prompt-put-widget "$color" "${PROMPT_SIGNS[SIGN_MODS]}$name"
}

function prompt-render {
    PROMPT=
    prompt-add-git
    prompt-add-mod "$PROMPT_HAS_VENV" "venv" COLOR_MOD_VENV
    prompt-add-error
    prompt-add-jobs
    prompt-add-dirs
    prompt-add-tip
    zle reset-prompt
}

#
# user functions
#

function prompt-reset-colors {
    typeset -g PROMPT_COLORS_INIT
    set -A PROMPT_COLORS ${(kv)PROMPT_COLORS_INIT}
}

function prompt-reset-signs {
    typeset -g PROMPT_SIGNS_INIT
    set -A PROMPT_SIGNS ${(kv)PROMPT_SIGNS_INIT}
}

function prompt-print-line {
    yes '─' | head -n "${COLUMNS:-80}" | tr -d '\n'
}

function prompt-config {
    prompt-print-line
    printf "%-32s = '%s'\n" PROMPT_SEPARATOR "$PROMPT_SEPARATOR"

    for name sign in ${(kv)PROMPT_SIGNS}; do
        printf "%-32s = '%s'\n" "PROMPT_SIGNS[$name]" "$sign"
    done
    prompt-print-line

    for name color in ${(kv)PROMPT_COLORS}; do
        printf "%-32s = \x1b[38;5;%sm%3s ████████\x1b[0m\n" \
            "PROMPT_COLORS[$name]" "$color" "$color"
    done
    prompt-print-line
}

#
# init prompt
#

prompt-reset-colors
prompt-reset-signs

function zle-line-init { prompt-render }
zle -N zle-line-init

function zle-keymap-select { prompt-render }
zle -N zle-keymap-select
