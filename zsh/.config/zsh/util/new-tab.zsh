local terminal="wezterm-gui"
local titlecmd="wezterm cli set-tab-title"

local prompttext="tab title"
local promptcolor=140

local default_title= # skips prompting if set

function set-tab-title() {
    local set_title="$1"
    local has_title=0
    local parent="$(ps -o comm -p $(ps -o ppid\= $$) | tail -n +2)"

    if grep -q "$terminal$" <<< "$parent"; then
        has_title=1
    fi

    if (( has_title )) && [ -z "$set_title" ]; then
        printf "\x1b[38;5;%sm%s\x1b[0m > " "$promptcolor" "$prompttext"
        read -r set_title
        clear
    fi

    if (( has_title )) && [ -n "$set_title" ]; then
        eval "$titlecmd "$set_title""
    fi
}

set-tab-title "$default_title"
