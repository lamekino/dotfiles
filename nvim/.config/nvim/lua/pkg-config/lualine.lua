-- https://github.com/nvim-lualine/lualine.nvim
local okay, lualine = pcall(require, "lualine")
if not okay then
    return
end

lualine.setup {
    options = {
        section_separators = "",
        component_separators = "|"
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { },
        lualine_c = { { "buffers", mode = 2 } },
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
