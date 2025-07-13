local M = {}

local function my_theme()
    local okay, theme = pcall(require, "lualine.themes.catppuccin-macchiato")
    if not okay then
        error("Could not load lualine theme")
        return nil
    end

    local is_dark = vim.o.background == "dark"
    local background = is_dark and "#141414" or "#efefef"

    -- swap normal and visual mode
    theme.normal.a, theme.visual.a = theme.visual.a, theme.normal.a

    local modes = { "normal", "visual", "insert", "replace", "command" }
    for _, mode in ipairs(modes) do
        theme[mode].c = {
            ["bg"] = background,
            ["fg"] = is_dark and theme[mode].a.bg or theme[mode].b.bg
        }
    end

    return theme
end

local function pad(tbl)
    tbl["separator"] = " "
    tbl["padding"] = 0

    return tbl
end

local __show_mode = {
    "mode",
    draw_empty = true,
    padding = 0,
    fmt = function()
        return ""
    end
}

local __show_filename = pad({
    "filename",
    path = 3
})

local __show_diff = pad({
    "diff"
})

local __show_diagnostics = pad({
    "diagnostics",
    symbols = {
        error = "*",
        warn = "!",
        info = "@",
        hint = "?"
    },
})

local __show_branch = pad({
    "branch",
    color = { fg = "#32cd32", gui = "italic" },
    fmt = function(branch)
        if branch == "" then
            return ""
        end

        return "@" .. branch
    end
})

local __show_location = function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    return string.format("%d:%d", row, col)
end

function M.setup()
    require("lualine").setup({
        options = {
            theme = my_theme(),
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
            lualine_a = { __show_mode },
            lualine_b = {},
            lualine_c = {
                __show_filename,
                __show_diff,
                __show_diagnostics
            },
            lualine_x = { __show_branch },
            lualine_y = {},
            lualine_z = {
                "encoding",
                "fileformat",
                __show_location
            },
        }
    })
end

return M
