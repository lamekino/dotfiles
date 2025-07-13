local set_title= # skips prompting if set

local terminal="wezterm-gui"
local titlecmd="wezterm cli set-tab-title"

local prompttext="tab title?"
local promptcolor=140

local has_terminal=0
local parent_pid="$(ps -o ppid\= $$ | xargs)" # xargs = trim string

# grep for the terminal name in the ppid's command name
if ps -o comm -p "$parent_pid" | tail -n +2 | grep -q "$terminal$"; then
    has_terminal=1
fi

if (( has_terminal )) && [ -z "$set_title" ]; then
    printf "\x1b[38;5;%sm%s\x1b[0m > " "$promptcolor" "$prompttext"
    read -r set_title
    clear
fi

if (( has_terminal )) && [ -n "$set_title" ]; then
    eval "$titlecmd '$set_title'"
fi
