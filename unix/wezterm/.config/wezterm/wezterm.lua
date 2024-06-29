local M = {}

local wezterm = require("wezterm")

-- Events
wezterm.on('format-window-title', function()
    local DEFAULT_TITLE = "WezTerm"
    return DEFAULT_TITLE
end)

wezterm.on('gui-startup', function(cmd)
    local env = cmd or {}
    local _, _, window = wezterm.mux.spawn_window(env)

    _ = window:spawn_tab(env)
end)

-- Shell
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    M.default_prog = { "pwsh.exe", "-NoLogo" }
end

-- Cursor
M.default_cursor_style = "SteadyUnderline"

-- Bell
M.audible_bell = "Disabled"

-- Fonts
M.font_size = 15.0
M.cell_width = 0.90
M.line_height = 1.00

M.font = wezterm.font({
    family = "IBM Plex Mono Text"
})

M.font_rules = {
    {
        intensity = "Bold",
        italic = false,
        font = wezterm.font("IBM Plex Mono", {
            weight = "Bold"
        })
    },
    {
        intensity = "Bold",
        italic = true,
        font = wezterm.font("IBM Plex Mono", {
            italic = true,
            weight = "Bold"
        })
    }
}

-- Colors
M.colors = {
    foreground = '#F1F1F1',
    background = '#101010',

    cursor_bg = "#F1F1F1",

    ansi = {
        '#352F2A', -- black
        '#B65C60', -- red
        '#78997A', -- green
        '#EBC06D', -- yellow
        '#9AACCE', -- blue
        '#B380B0', -- magenta
        '#86A3A3', -- cyan
        '#A0A0A0', -- white
    },
    brights = {
        '#4D453E', -- black
        '#F17C64', -- red
        '#99D59D', -- green
        '#EBC06D', -- yellow
        '#9AACCE', -- blue
        '#CE9BCB', -- magenta
        '#88B3B2', -- cyan
        '#F1F1F1', -- white
    },
}

-- Keyboard
M.enable_csi_u_key_encoding = true
M.keys = {
    {
        key = '[',
        mods = 'CTRL',
        action = wezterm.action.SendKey({ key = "Escape" })
    }
}

-- Mouse
M.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = wezterm.action.PasteFrom("Clipboard"),
    },
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'SHIFT',
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}

-- Tabs
M.enable_tab_bar = false

-- Window
M.window_close_confirmation = 'NeverPrompt'
M.hide_tab_bar_if_only_one_tab = true
M.window_background_opacity = 0.87

M.window_padding = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 4
}

return M
