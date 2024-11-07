local M = {}

M.tweaks = require("my.highlight.tweaks")
M.diagnostics = require("my.highlight.line-diagnostics")

M.set_colors = function(colormode)
    local name = "catppuccin-frappe"
    if colormode == "light" then
        name = "catppuccin-latte"
    end

    pcall(function()
        vim.cmd.colorscheme(name)
    end)
end

return M
