vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_comments = false
-- vim.g.tokyonight_transparent     = true
-- vim.o.background = "light"
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
vim.g.gruvbox_transparent_bg = 1
vim.g.gruvbox_contrast_dark = "hard"
-- vim.cmd [[colorscheme gruvbox]]
-- vim.cmd [[colorscheme tokyonight]]
vim.cmd [[colorscheme catppuccin]]

-- configure dignostic sign on line number
vim.cmd [[
    highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
    highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
    highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
    highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]
