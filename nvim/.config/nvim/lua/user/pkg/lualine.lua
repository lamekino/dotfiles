-- https://github.com/nvim-lualine/lualine.nvim
require("lualine").setup {
    options = {
        section_separators = "",
        component_separators = "|"
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = {
            {
                "buffers",
                show_filename_only = true,
                mode = 0,
                buffers_color = {
                    inactive = 'StatusLineNC',
                    -- active = 'User1',
                },
                symbols = {
                    modified = "+",
                    alternate_file = "",
                    directory = "/"
                }
            }
        },
        lualine_x = {
            "encoding",
            {
                "fileformat",
                symbols = {
                    unix = "unix",
                    dos  = "dos",
                    mac  = "mac"
                },
            },
            "filetype"
        },
        lualine_y = {
            "location",
            {
                "diagnostics",
                symbols = {
                    error = '*',
                    warn = '!',
                    info = '@',
                    hint = '?'
                },
            },
            "diff"
        },
        lualine_z = {
            { "branch", icon = "*" }
        }
    },
}
