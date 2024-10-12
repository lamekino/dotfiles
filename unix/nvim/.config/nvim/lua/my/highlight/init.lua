local M = {}

M.tweaks = require("my.highlight.tweaks")
M.diagnostics = require("my.highlight.line-diagnostics")

M.colorscheme = function(name)
    pcall(function()
        vim.cmd.colorscheme(name)
    end)
end

return M
