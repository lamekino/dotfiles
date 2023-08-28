local okay, lualine = pcall(require, "lualine")
if not okay then return end

local cseparator = function(left, right)
    return { left = left, right = right }
end

local diag_sym = {
    error = '*',
    warn = '!',
    info = '@',
    hint = '?'
}

local a = {
    {
        "mode",
        draw_empty = true,
        fmt = function() return "" end
    }
}

local b = {}

local c = {
    {
        "filename",
        path = 3,
        separator = " ",
        padding = 0,
        fmt = function(s) return " " .. s end
    },
    {
        "diff",
        separator = " ",
        padding = 0,
    },
    {
        "diagnostics",
        symbols = diag_sym,
        separator = " ",
        padding = 0
    }
}

local x = {
    {
        "branch",
        icons_enabled = true,
        icon = "*",
    }
}

local y = {}

local z = { "encoding", "fileformat", "filetype" }

lualine.setup {
    options = {
        icons_enabled = false,
        component_separators = cseparator("│", "│"),
        section_separators = cseparator("▓▒░", "░▒▓"),
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
