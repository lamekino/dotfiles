local M = {}

local schemes = {
    ["dark"] = "catppuccin-mocha",
    ["light"] = "catppuccin-latte"
}

M.tweaks = require("my.colorscheme.tweaks")
M.diagnostics = require("my.colorscheme.line-diagnostics")

function M.setup(colormode)
    vim.api.nvim_create_autocmd("Colorscheme", {
        group    = vim.api.nvim_create_augroup("LspDiagnosticLineNo", {}),
        callback = M.diagnostics.create_callback(colormode)
    })

    vim.api.nvim_create_autocmd("Colorscheme", {
        group    = vim.api.nvim_create_augroup("ColorschemeTweaks", {}),
        callback = M.tweaks.create_callback(colormode)
    })

    local ok = pcall(function(cs) vim.cmd.colorscheme(cs) end, schemes[colormode])
    vim.o.background = colormode
end

return M
