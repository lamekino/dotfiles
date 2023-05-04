-- Spellcheck
vim.api.nvim_create_augroup("PlainText", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
    group = "PlainText",
    desc = "sets options for editing plain text files",
    pattern = { "*.md", "*.txt" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.textwidth = 80
        vim.opt_local.wrapmargin = 2
    end
})

-- Autogroups on file write
vim.api.nvim_create_augroup("RemoveTrailing", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = "RemoveTrailing",
    desc = "remove trailing whitespace on write.",
    command = ":%s/\\s\\+$//e"
})

-- Autogroups which make vim prettier
vim.api.nvim_create_augroup("VisualFX", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group    = "VisualFX",
    desc     = "highlight on yanking text.",
    callback = function()
        vim.highlight.on_yank()
    end
})
