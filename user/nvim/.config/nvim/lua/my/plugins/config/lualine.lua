local M = {}

local dark_bg = "#141414"
local light_bg = "#efefef"

local my_theme = (function(theme)
    local is_dark = vim.o.background == "dark"
    local background = is_dark and dark_bg or light_bg

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
            ["fg"] = light_bg
        }
    end

    return theme
end)

local italic = (function(tbl)
    tbl.color = tbl.color or {}
    tbl.color.gui = "italic"
    return tbl
end)

local light_text = (function(tbl)
    tbl.color = tbl.color or {}
    tbl.color.fg = light_bg
    return tbl
end)

local fixed = (function(tbl)
    tbl.separator = " "
    tbl.padding = 0
    return tbl
end)

-- left
local show_branch = fixed(italic(light_text({
    "branch",
    fmt = function(branch)
        local text = branch ~= "" and branch or ""
        return string.format(" ✦%s ", text)
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
local show_encoding = italic(light_text({ "encoding" }))
local show_format = italic(light_text({ "fileformat" }))
local show_location = italic(light_text({
    "mode", -- updates on cursor move, and i don't use it ¯\_(ツ)_/¯
    fmt = function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        return string.format("%d:%d", row, col)
    end
}))

M.setup = (function()
    local okay, theme = pcall(require, "lualine.themes.catppuccin-macchiato")
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
