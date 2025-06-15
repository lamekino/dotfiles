local terminal="wezterm-gui"
local titlecmd="wezterm cli set-tab-title"

local set_title= # skips prompting if set
local fallback_title="untitled"

local prompttext="tab title?"
local promptcolor=140

local has_terminal=0
local shell_parent="$(ps -o ppid\= $$)"

# set the default if ctrl-c is pressed
trap "$titlecmd '$fallback_title'; trap -; return" INT TERM

# grep for the terminal name in the ppid's command name
if ps -o comm -p "$shell_parent" | tail -n +2 | grep -q "$terminal$"; then
    has_terminal=1
fi

if (( has_terminal )) && [ -z "$set_title" ]; then
    printf "\x1b[38;5;%sm%s\x1b[0m > " "$promptcolor" "$prompttext"
    read -r set_title
    clear
fi

if (( has_terminal )); then
    # set default if ctrl-d is pressed
    [ -z "$set_title" ] && set_title="$fallback_title"
    eval "$titlecmd '$set_title'"
fi

trap - # reset trap handlers
