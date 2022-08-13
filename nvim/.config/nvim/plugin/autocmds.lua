-- Startup
vim.api.nvim_create_augroup("StartupFunc", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
    group    = "StartupFunc",
    desc     = "open vim to :Explore on no args",
    callback = function()
        -- https://vi.stackexchange.com/a/715
        local has_args = function()
            return vim.fn.argc() ~= 0
                or vim.fn.line2byte('$') ~= -1
                or string.match(vim.v.progname, '^[-gmnq]\\=vim\\=x\\=\\%[\\.exe]$')
        end
        if not has_args() then
            vim.cmd("Explore")
        end
    end
})

vim.api.nvim_create_autocmd("VimEnter", {
    group    = "StartupFunc",
    desc     = "set termguicolors",
    callback = function()
        vim.o.termguicolors = true
    end
})

-- Spellcheck
vim.api.nvim_create_augroup("Spellcheck", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
    group = "Spellcheck",
    desc = "sets spellcheck for filetypes",
    pattern = { "*.md", "*.txt" },
    callback = function()
        vim.o.spell = true
    end
})


-- Autogroups on file write
vim.api.nvim_create_augroup("FileMod", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = "FileMod",
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
