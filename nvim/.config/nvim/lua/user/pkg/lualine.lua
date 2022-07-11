local lualine = require("lualine")
local config = lualine.get_config() -- defaults

config.options = {
    icons_enabled = false,
    -- component_separators = '',
    component_separators = {
        left  = "│",
        right = "│"
    },
    section_separators = {
        left  = "▓▒░",
        right = "░▒▓"
    },
}

config.sections.lualine_a = { { "mode", fmt = string.lower } }
config.sections.lualine_b = { { "branch", icons_enabled = true } }

-- replace the filename default with a list of buffers
config.sections.lualine_c = {
    {
        "buffers",
        show_filename_only = false,
        mode = 0,
        buffers_color = {
            inactive = "StatusLineNC",
        },
        symbols = {
            modified = "+",
            alternate_file = "",
            directory = "/"
        }
    }
}

config.sections.lualine_x = {
    "diff",
    {
        "diagnostics",
        symbols = {
            error = '*',
            warn = '!', info = '@',
            hint = '?'
        },
    }
}

config.sections.lualine_y = { "location" }

config.sections.lualine_z = { "encoding", "fileformat", "filetype" }

lualine.setup(config)
