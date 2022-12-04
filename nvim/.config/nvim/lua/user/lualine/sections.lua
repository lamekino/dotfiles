local M = {}
local diag_sym = {
    error = '*',
    warn = '!',
    info = '@',
    hint = '?'
}

M.a = { { "mode", fmt = string.lower } }

M.b = {}

M.c = { { "filename", path = 3 } }

M.x = { { "diagnostics", symbols = diag_sym } }

M.y = {
    { "branch",
        icons_enabled = true,
        icon = "*" },
    "diff"
}


M.z = { "encoding", "fileformat", "filetype", "location" }

return M
