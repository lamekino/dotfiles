local my = require("my.highlight")

vim.api.nvim_create_autocmd("Colorscheme", {
    group    = vim.api.nvim_create_augroup("LspDiagnosticLineNo", {}),
    callback = my.diagnostics.callback
})

vim.api.nvim_create_autocmd("Colorscheme", {
    group    = vim.api.nvim_create_augroup("ColorschemeTweaks", {}),
    callback = my.tweaks.callback
})

my.colorscheme("catppuccin-macchiato", "dark")
