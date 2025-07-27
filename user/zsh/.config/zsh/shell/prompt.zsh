PROMPT= # if set, this will be above the first shown line (scroll up)

PROMPT_SEPARATOR=":" # separates elements added with _append_prompt

typeset -gA PROMPT_SIGNS # holds the current prompt symbols
typeset -gA PROMPT_SIGNS_INIT=( # default/reset symbols
    ["SIGN_MODS"]="&"
    ["SIGN_DIRS"]="~"
    ["SIGN_JOBS"]="%%"
    ["SIGN_ERROR"]="!"
    ["SIGN_GIT"]="@"
)

typeset -gA PROMPT_COLORS # holds the current prompt colors
typeset -gA PROMPT_COLORS_INIT=( # default/reset colors
    ["COLOR_ERROR"]=1
    ["COLOR_JOBS"]=166
    ["COLOR_MODS"]=14
    ["COLOR_DIRS"]=38
    ["COLOR_GIT_CLEAN"]=34
    ["COLOR_GIT_DIRTY"]=162
    ["COLOR_PWD"]=99
    ["COLOR_TIP"]=15
)

#
# internal functions
#

function _write_prompt {
    typeset -g PROMPT_COLORS
    PROMPT="$PROMPT%F{${PROMPT_COLORS[$1]}}$3%f$2"
}

function _append_prompt {
    typeset -g PROMPT_COLORS
    PROMPT="$PROMPT%F{${PROMPT_COLORS[$1]}}$2%f$PROMPT_SEPARATOR"
}

function _prompt_jobs {
    _write_prompt COLOR_JOBS \
        "%(1j.$PROMPT_SEPARATOR.)" \
        "%(1j.${PROMPT_SIGNS[SIGN_JOBS]}%j.)"
}

function _prompt_error {
    _write_prompt COLOR_ERROR \
        "%(?..$PROMPT_SEPARATOR)" \
        "%(?..${PROMPT_SIGNS[SIGN_ERROR]}%?)"
}

function _prompt_tip {
    local tip="%#"

    [ "$KEYMAP" = "vicmd" ] && tip="|"

    _write_prompt COLOR_PWD "" "%~"
    _write_prompt COLOR_TIP " " "$tip"
}

function _prompt_dirs {
    local dirs_count="${1-0}"

    (( dirs_count < 2 )) && return
    _append_prompt COLOR_DIRS "${PROMPT_SIGNS[SIGN_DIRS]}${dirs_count}"
}

function _prompt_git {
    [ -z "${1-}" ] && return

    local git_branch="$1"
    local git_color=COLOR_GIT_CLEAN
    local git_str="${PROMPT_SIGNS[SIGN_GIT]}${git_branch}"

    # xargs trims whitespace
    local git_changes="$(git status --short 2>/dev/null | wc -l | xargs)"

    if (( git_changes > 0 )); then
        git_color=COLOR_GIT_DIRTY
        git_str="${git_str}+${git_changes}"
    fi

    _append_prompt "$git_color" "$git_str"
}

function _prompt_venv {
    [ -f "${VIRTUAL_ENV-}" ] || return

    _append_prompt COLOR_MODS "${PROMPT_SIGNS[SIGN_MODS]}venv"
}

function _build_prompt {
    local dirs_count="$1" git_branch="$2"

    PROMPT=
    _prompt_git "$git_branch"
    _prompt_venv
    _prompt_error
    _prompt_jobs
    _prompt_dirs "$dirs_count"
    _prompt_tip
}

function _render_prompt {
    local dirs_count="$(dirs -v | wc -l | xargs)"
    local git_branch="$(git branch --show-current 2>/dev/null)"

    _build_prompt "$dirs_count" "$git_branch"
    zle reset-prompt
}

#
# user functions
#

function prompt-reset-colors {
    set -A PROMPT_SIGNS ${(kv)PROMPT_SIGNS_INIT}
    set -A PROMPT_COLORS ${(kv)PROMPT_COLORS_INIT}

    # tweaks
    [ -n "$SSH_CONNECTION" ] && PROMPT_COLORS[COLOR_PWD]=208

    return 0
}

function prompt-config-show {
    printf "%-32s = '%s'\n" PROMPT_SEPARATOR "$PROMPT_DEFAULT_SEP"

    for name sign in ${(kv)PROMPT_SIGNS}; do
        printf "%-32s = '%s'\n" "PROMPT_SIGNS[$name]" "$sign"
    done

    for name color in ${(kv)PROMPT_COLORS}; do
        printf "%-32s = \x1b[38;5;%sm%3s ████████\x1b[0m\n" \
            "PROMPT_COLORS[$name]" "$color" "$color"
    done
}


#
# init prompt
#

prompt-reset-colors

function zle-line-init { _render_prompt }
zle -N zle-line-init

function zle-keymap-select { _render_prompt }
zle -N zle-keymap-select
