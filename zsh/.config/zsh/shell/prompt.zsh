PROMPT="" # if set, this string will be above the first shown line (scroll up)

export PROMPT_SEP=':'

export PROMPT_SIGN_MODS='&'
export PROMPT_SIGN_DIRS='~'
export PROMPT_SIGN_JOBS='%%'
export PROMPT_SIGN_ERR='!'
export PROMPT_SIGN_GIT='@'

export PROMPT_COLOR_ERR_LVL=1
export PROMPT_COLOR_JOB_COUNT=3
export PROMPT_COLOR_SHELL_MODS=14
export PROMPT_COLOR_DIR_STACK=164
export PROMPT_COLOR_GIT_CLEAN=10
export PROMPT_COLOR_GIT_DIRTY=168
export PROMPT_COLOR_PWD=140
export PROMPT_COLOR_TIP=15

function printer { printf '%%F{%s}%s%%f%s' "$2" "$3" "$1" }
function renderer { printer "$PROMPT_SEP" "$1" "$2" }

function my-prompt-config {
    local -a signs=(
        "PROMPT_SIGN_MODS"
        "PROMPT_SIGN_DIRS"
        "PROMPT_SIGN_JOBS"
        "PROMPT_SIGN_ERR"
        "PROMPT_SIGN_GIT"
    )
    local -a colors=(
        "PROMPT_COLOR_ERR_LVL"
        "PROMPT_COLOR_JOB_COUNT"
        "PROMPT_COLOR_SHELL_MODS"
        "PROMPT_COLOR_DIR_STACK"
        "PROMPT_COLOR_GIT_CLEAN"
        "PROMPT_COLOR_GIT_DIRTY"
        "PROMPT_COLOR_PWD"
        "PROMPT_COLOR_TIP"
    )


    for sign in "PROMPT_SEP" ${signs[@]}; do
        printf "%-24s = '%s'\n" "$sign" "${(P)sign}"
    done

    for color in ${colors[@]}; do
        printf "%-24s = %-5s \e[48;5;%sm     \e[0m\n" \
            "$color" "${(P)color}" "${(P)color}"
    done
}

function prompt-job-count {
    printer \
        "%(1j.$PROMPT_SEP.)" \
        "$PROMPT_COLOR_JOB_COUNT" \
        "%(1j.${PROMPT_SIGN_JOBS}%j.)"
}

function prompt-err-level {
    printer \
        "%(?..$PROMPT_SEP)" \
        "$PROMPT_COLOR_ERR_LVL" \
        "%(?..${PROMPT_SIGN_ERR}%?)"
}

function prompt-tip {
    printer "" "$PROMPT_COLOR_PWD" "%~"

    case "$KEYMAP" in
    viins|main)
        printer " " "$PROMPT_COLOR_TIP" '%#'
        ;;
    vicmd)
        printer " " "$PROMPT_COLOR_TIP" '|'
        ;;
    esac
}

function my-prompt-render {
    local numdirs="$1" branch="$2"

    function prompt-shell-mods { : }
    function prompt-dir-count { : }
    function prompt-git-branch { : }

    if [ -n "$VIRTUAL_ENV"  ]; then
        function prompt-shell-mods {
            renderer "$PROMPT_COLOR_SHELL_MODS" "${PROMPT_SIGN_MODS}venv"
        }
    fi

    if (( numdirs > 1 )); then
        function prompt-dir-count {
            renderer "$PROMPT_COLOR_DIR_STACK" "${PROMPT_SIGN_DIRS}${numdirs}"
        }
    fi

    if [ -n "$branch" ]; then
        function prompt-git-branch {
            local changes=$(git status --short 2>/dev/null | wc -l)

            if [ $changes -eq 0 ]; then
                renderer \
                    "$PROMPT_COLOR_GIT_CLEAN" \
                    "${PROMPT_SIGN_GIT}${branch}"
            else
                renderer \
                    "$PROMPT_COLOR_GIT_DIRTY" \
                    "${PROMPT_SIGN_GIT}${branch}+${changes}"
            fi
        }
    fi

    prompt-git-branch
    prompt-shell-mods
    prompt-err-level
    prompt-job-count
    prompt-dir-count
    prompt-tip
}

function my-prompt-set {
    local numdirs="$(dirs -v | wc -l)"
    local branch="$(git branch --show-current 2>/dev/null)"

    PROMPT="$(my-prompt-render "$numdirs" "$branch")"
    zle reset-prompt
}

function zle-line-init { my-prompt-set }
zle -N zle-line-init

function zle-keymap-select { my-prompt-set }
zle -N zle-keymap-select
