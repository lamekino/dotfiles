PROMPT= # if set, this string will be above the first shown line (scroll up)

PROMPT_DEFAULT_SEP=":"

typeset -gA PROMPT_SIGNS PROMPT_SIGNS_DEFAULT=(
    ["SIGN_MODS"]="&"
    ["SIGN_DIRS"]="~"
    ["SIGN_JOBS"]="%%"
    ["SIGN_ERROR"]="!"
    ["SIGN_GIT"]="@"
)

typeset -gA PROMPT_COLORS PROMPT_COLORS_DEFAULT=(
    ["COLOR_ERROR"]=1
    ["COLOR_JOBS"]=3
    ["COLOR_MODS"]=14
    ["COLOR_DIRS"]=164
    ["COLOR_GIT_CLEAN"]=10
    ["COLOR_GIT_DIRTY"]=168
    ["COLOR_PWD"]=99
    ["COLOR_TIP"]=15
)

function zsh-prompt-reset-colors {
    set -A PROMPT_SIGNS ${(kv)PROMPT_SIGNS_DEFAULT}
    set -A PROMPT_COLORS ${(kv)PROMPT_COLORS_DEFAULT}

    # tweaks
    [ -n "$SSH_CONNECTION" ] && PROMPT_COLORS[COLOR_PWD]=208

    return 0
}

function zsh-prompt-config-show {
    printf "%-32s = '%s'\n" PROMPT_DEFAULT_SEP "$PROMPT_DEFAULT_SEP"

    for name sign in ${(kv)PROMPT_SIGNS}; do
        printf "%-32s = '%s'\n" "PROMPT_SIGNS[$name]" "$sign"
    done

    for name color in ${(kv)PROMPT_COLORS}; do
        printf "%-32s = \x1b[38;5;%sm%3s ████████\x1b[0m\n" \
            "PROMPT_COLORS[$name]" "$color" "$color"
    done
}

function _write_prompt {
    typeset -g PROMPT_COLORS
    PROMPT="$PROMPT%F{${PROMPT_COLORS[$1]}}$3%f$2"
}

function _append_prompt {
    typeset -g PROMPT_COLORS
    PROMPT="$PROMPT%F{${PROMPT_COLORS[$1]}}$2%f$PROMPT_DEFAULT_SEP"
}

function _prompt_jobs {
    _write_prompt COLOR_JOBS \
        "%(1j.$PROMPT_DEFAULT_SEP.)" \
        "%(1j.${PROMPT_SIGNS[SIGN_JOBS]}%j.)"
}

function _prompt_error {
    _write_prompt COLOR_ERROR \
        "%(?..$PROMPT_DEFAULT_SEP)" \
        "%(?..${PROMPT_SIGNS[SIGN_ERROR]}%?)"
}

function _prompt_tip {
    local tip="%#"

    [ "$KEYMAP" = "vicmd" ] && tip="|"

    _write_prompt COLOR_PWD "" "%~"
    _write_prompt COLOR_TIP " " "$tip"
}

function _build_prompt {
    local dirs_count="$1" git_branch="$2"

    function _prompt_venv { : }
    function _prompt_dirs { : }
    function _prompt_git { : }

    if [ -f "$VIRTUAL_ENV"  ]; then
        function _prompt_venv {
            _append_prompt COLOR_MODS "${PROMPT_SIGNS[SIGN_MODS]}venv"
        }
    fi

    if (( dirs_count > 1 )); then
        function _prompt_dirs {
            _append_prompt COLOR_DIRS "${PROMPT_SIGNS[SIGN_DIRS]}${dirs_count}"
        }
    fi

    if [ -n "$git_branch" ]; then
        local git_color=COLOR_GIT_CLEAN
        local git_str="${PROMPT_SIGNS[SIGN_GIT]}${git_branch}"

        # xargs trims whitespace
        local git_changes="$(git status --short 2>/dev/null | wc -l | xargs)"

        if (( git_changes > 0 )); then
            git_color=COLOR_GIT_DIRTY
            git_str="${git_str}+${git_changes}"
        fi

        function _prompt_git {
            _append_prompt "$git_color" "$git_str"
        }
    fi

    PROMPT=
    _prompt_git
    _prompt_venv
    _prompt_error
    _prompt_jobs
    _prompt_dirs
    _prompt_tip
}

function _render_prompt {
    local dirs_count="$(dirs -v | wc -l | xargs)"
    local git_branch="$(git branch --show-current 2>/dev/null)"

    _build_prompt "$dirs_count" "$git_branch"
    zle reset-prompt
}

zsh-prompt-reset-colors

function zle-line-init { _render_prompt }
zle -N zle-line-init

function zle-keymap-select { _render_prompt }
zle -N zle-keymap-select
