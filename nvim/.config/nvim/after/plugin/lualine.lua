local okay, lualine = pcall(require, "lualine")
if not okay then return end

local my_theme = require("my.aesthetic.lualine-theme")

local function pad(tbl)
    tbl["separator"] = " "
    tbl["padding"] = 0

    return tbl
end

local config_mode = {
    "mode",
    draw_empty = true,
    padding = 0,
    fmt = function()
        return ""
    end
}

local config_filename = pad({
    "filename",
    path = 3
})

local config_diff = pad({
    "diff"
})

local config_diagnostics = pad({
    "diagnostics",
    symbols = {
        error = '*',
        warn = '!',
        info = '@',
        hint = '?'
    },
})

local config_branch = pad({
    "branch",
    color = { fg = '#32cd32', gui = 'italic' },
    fmt = function(branch)
        if branch == "" then
            return ""
        end

        return "@" .. branch
    end
})

local config_location = function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    return string.format("%d:%d", row, col)
end

lualine.setup {
    options = {
        theme = my_theme,
        icons_enabled = false,
        component_separators = {
            left = "",
            right = "│"
        },
        section_separators = {
            left = "▓▒░ ",
            right = " ░▒▓"
        },
    },

    sections = {
        lualine_a = { config_mode },
        lualine_b = {},
        lualine_c = { config_filename, config_diff, config_diagnostics },
        lualine_x = { config_branch },
        lualine_y = {},
        lualine_z = { "encoding", "fileformat", config_location },
    }
}
