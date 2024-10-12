local my = require("my.highlight")

local colormode = vim.o.background

vim.api.nvim_create_autocmd("Colorscheme", {
    group    = vim.api.nvim_create_augroup("LspDiagnosticLineNo", {}),
    callback = my.diagnostics.create_callback(colormode)
})

vim.api.nvim_create_autocmd("Colorscheme", {
    group    = vim.api.nvim_create_augroup("ColorschemeTweaks", {}),
    callback = my.tweaks.create_callback(colormode)
})

-- TODO: don't pass colorscheme name decide on colormode... maybe
my.colorscheme("catppuccin-latte")
