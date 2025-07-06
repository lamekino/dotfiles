local M = {}

M.tweaks = require("my.colorscheme.tweaks")

M.colorschemes = {
    ["dark"] = "catppuccin-mocha",
    ["light"] = "catppuccin-latte"
}

function M.setup(colormode)
    require("my.colorscheme.diagnostics").setup(colormode)

    vim.api.nvim_create_autocmd("Colorscheme", {
        group    = vim.api.nvim_create_augroup("ColorschemeTweaks", {}),
        callback = M.tweaks.create_callback(colormode)
    })

    _ = pcall(vim.cmd.colorscheme, M.colorschemes[colormode])
    vim.o.background = colormode
end

return M
