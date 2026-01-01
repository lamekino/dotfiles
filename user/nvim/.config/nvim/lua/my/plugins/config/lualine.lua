local M = {}

local colors = require("my.colorscheme.colors")

local is_dark = vim.o.background == "dark"
local background = is_dark and colors.dark.bg or colors.light.bg
local theme_name = "catppuccin-macchiato"

local my_theme = (function(theme)
    -- swap visual and normal modes' color for light mode
    local _1st, _2nd = theme.normal, theme.visual
    _1st.a, _2nd.a = _2nd.a, _1st.a

    for _, mode in ipairs({
        "normal", "visual", "insert", "replace", "command"
    }) do
        theme[mode].c = {
            ["bg"] = background,
            ["fg"] = is_dark and theme[mode].a.bg or theme[mode].b.bg
        }
        theme[mode].z = {
            ["bg"] = theme[mode].a.bg,
            ["fg"] = background
        }
    end

    return theme
end)

local italic = (function(tbl)
    tbl.color = tbl.color or {}
    tbl.color.gui = "italic"
    return tbl
end)

local colormode_text = (function(tbl)
    tbl.color = tbl.color or {}
    tbl.color.fg = is_dark and colors.dark.bg or colors.light.bg
    return tbl
end)

local fixed = (function(tbl)
    tbl.separator = " "
    tbl.padding = 0
    return tbl
end)

-- left
local show_branch = fixed(italic(colormode_text({
    "branch",
    fmt = function(branch)
        return string.format(" *%s ", branch)
    end
})))

-- middle
local show_filename = fixed({ "filename", path = 3 })
local show_diff = fixed({ "diff" })
local show_diagnostics = fixed({
    "diagnostics",
    symbols = {
        error = "*",
        warn = "!",
        info = "@",
        hint = "?"
    },
})

-- right
local show_encoding = italic(colormode_text({ "encoding" }))
local show_format = italic(colormode_text({ "fileformat" }))
local show_location = italic(colormode_text({
    "mode", -- updates on cursor move and i don't use it ¯\_(ツ)_/¯
    fmt = function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        return string.format("%d:%d", row, col)
    end
}))

M.setup = (function()
    local okay, theme = pcall(require, "lualine.themes." .. theme_name)
    if not okay then
        return error("Could not load lualine theme")
    end

    require("lualine").setup({
        options = {
            theme = my_theme(theme),
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
            lualine_a = { show_branch },
            lualine_b = {},
            lualine_c = { show_filename, show_diff, show_diagnostics },
            lualine_x = {},
            lualine_y = {},
            lualine_z = { show_encoding, show_format, show_location },
        }
    })
end)

return M
