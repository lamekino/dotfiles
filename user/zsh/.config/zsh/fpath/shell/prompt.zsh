PROMPT= # if set, this will be above the first shown line (scroll up)

PROMPT_SEPARATOR=":" # separates elements added with _put_widget

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
    ["COLOR_VENV"]=14
    ["COLOR_SSH"]=208
    ["COLOR_DIRS"]=38
    ["COLOR_GIT_CLEAN"]=34
    ["COLOR_GIT_DIRTY"]=162
    ["COLOR_PWD"]=99
    ["COLOR_TIP"]=15
)

# prompt info toggles
[ -r "${VIRTUAL_ENV-}" ] && PROMPT_HAS_VENV=1
[ -n "${SSH_CONNECTION-}" ] && PROMPT_HAS_SSH=1

(( PROMPT_HAS_SSH )) && PROMPT_SSH_HOST="$(hostname -s)" # short hostname

#
# internal functions
#

function _put_text {
    typeset -g PROMPT_COLORS
    PROMPT="$PROMPT%F{${PROMPT_COLORS[$1]}}$2%f$3"
}

function _put_widget {
    typeset -g PROMPT_COLORS
    PROMPT="$PROMPT%F{${PROMPT_COLORS[$1]}}$2%f$PROMPT_SEPARATOR"
}

function _prompt_jobs {
    _put_text COLOR_JOBS \
        "%(1j.${PROMPT_SIGNS[SIGN_JOBS]}%j.)" \
        "%(1j.$PROMPT_SEPARATOR.)"
}

function _prompt_error {
    _put_text COLOR_ERROR \
        "%(?..${PROMPT_SIGNS[SIGN_ERROR]}%?)" \
        "%(?..$PROMPT_SEPARATOR)"
}

function _prompt_tip {
    local tip="%#"

    [ "$KEYMAP" = "vicmd" ] && tip="|"

    _put_text COLOR_PWD "%~" ""
    _put_text COLOR_TIP "$tip" " "
}

function _prompt_dirs {
    local dirs_count="${1-0}"

    (( dirs_count < 2 )) && return 1

    _put_widget COLOR_DIRS "${PROMPT_SIGNS[SIGN_DIRS]}${dirs_count}"
}

function _prompt_git {
    [ -z "${1-}" ] && return 1

    local git_branch="$1"
    local git_color=COLOR_GIT_CLEAN
    local git_str="${PROMPT_SIGNS[SIGN_GIT]}${git_branch}"

    # xargs trims whitespace
    local git_changes="$(git status --short 2>/dev/null | wc -l | xargs)"

    if (( git_changes > 0 )); then
        git_color=COLOR_GIT_DIRTY
        git_str="${git_str}+${git_changes}"
    fi

    _put_widget "$git_color" "$git_str"
}

function _prompt_mod {
    local cond="$1" name="$2" color="$3"

    ! (( cond )) && return 1

    _put_widget "$color" "${PROMPT_SIGNS[SIGN_MODS]}$name"
}

function _render_prompt {
    local dirs_count="$(dirs -v | wc -l | xargs)"
    local git_branch="$(git branch --show-current 2>/dev/null)"

    PROMPT=
    _prompt_git "$git_branch"
    _prompt_mod "$PROMPT_HAS_SSH" "$PROMPT_SSH_HOST" COLOR_SSH
    _prompt_mod "$PROMPT_HAS_VENV" "venv" COLOR_VENV
    _prompt_error
    _prompt_jobs
    _prompt_dirs "$dirs_count"
    _prompt_tip

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

function prompt-config-show {
    printf "%-32s = '%s'\n" PROMPT_SEPARATOR "$PROMPT_SEPARATOR"

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
prompt-reset-signs

function zle-line-init { _render_prompt }
zle -N zle-line-init

function zle-keymap-select { _render_prompt }
zle -N zle-keymap-select
