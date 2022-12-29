local diag_sym = {
    error = '*',
    warn = '!',
    info = '@',
    hint = '?'
}

local a = { { "mode", fmt = string.lower } }

local b = {}

local c = { { "filename", path = 3 } }

local x = { { "diagnostics", symbols = diag_sym } }

local y = {
    { "branch",
        icons_enabled = true,
        icon = "*" },
    "diff"
}

local z = { "encoding", "fileformat", "filetype", "location" }

require("lualine").setup {
    options = {
        icons_enabled = false,
        component_separators = {
            left  = "│",
            right = "│"
        },
        section_separators = {
            left  = "▓▒░",
            right = "░▒▓"
        },
    },

    sections = {
        lualine_a = a,
        lualine_b = b,
        lualine_c = c,
        lualine_x = x,
        lualine_y = y,
        lualine_z = z,
    }
}
