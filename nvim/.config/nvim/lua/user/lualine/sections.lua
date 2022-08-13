local M = {}

M.a = {
    { "mode",
        fmt = string.lower }
}

M.b = {
    { "branch",
        icons_enabled = true,
        icon = "*" }
}

M.c = {
    { "buffers",
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

M.x = {
    "diff",
    { "diagnostics",
        symbols = {
            error = '*',
            warn = '!',
            info = '@',
            hint = '?'
        }
    }
}

M.y = { "location" }
M.z = { "encoding", "fileformat", "filetype" }

return M
