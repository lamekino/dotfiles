local M = {}

M.tweaks = require("my.highlight.tweaks")
M.diagnostics = require("my.highlight.diagnostics")

M.colorscheme = function (name, type)
    vim.o.background = type
    pcall(function()
        vim.cmd.colorscheme(name)
    end)
end

return M
