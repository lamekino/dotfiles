local function theme_tweaks(theme)
    local background = "#141414"
    local swap = theme.normal.a

    theme.normal.a = theme.visual.a
    theme.visual.a = swap

    local modes = { "normal", "visual", "insert", "replace", "command" }
    for _, mode in ipairs(modes) do
        theme[mode].c = {
            ["bg"] = background,
            ["fg"] = theme[mode].a.bg
        }
    end
end

local okay, lualine = pcall(require, "lualine")
if not okay then return end

local okay, theme = pcall(require, "lualine.themes.catppuccin-macchiato")
if okay then theme_tweaks(theme) end

local mode_config = {
    "mode",
    draw_empty = true,
    padding = 0,
    fmt = function() return "" end
}

local filename_config = {
    "filename",
    path = 3,
    separator = " ",
    padding = 0,
    fmt = function(s) return " " .. s end
}

local diff_config = {
    "diff",
    separator = " ",
    padding = 0,
}

local diags_config = {
    "diagnostics",
    symbols = {
        error = '*',
        warn = '!',
        info = '@',
        hint = '?'
    },
    separator = " ",
    padding = 0
}

local branch_config = {
    "branch",
    icons_enabled = true,
    icon = "*",
}


lualine.setup {
    options = {
        theme = theme,
        icons_enabled = false,
        component_separators = {
            left = "│",
            right = "│"
        },
        section_separators = {
            left = "▓▒░",
            right = "░▒▓"
        },
    },

    sections = {
        lualine_a = { mode_config },
        lualine_b = {},
        lualine_c = { filename_config, diff_config, diags_config },
        lualine_x = { branch_config },
        lualine_y = {},
        lualine_z = { "encoding", "fileformat", "filetype" },
    }
}
