local M = {}
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

M.setup = function()
    -- Autogroups for terminal
    augroup("Terminal", { clear = true })

    autocmd("TermOpen", {
        group = "Terminal",
        desc = "remove line numbers from terminal",
        callback = function()
            vim.opt_local.rnu = false
            vim.opt_local.nu  = false
        end
    })

    -- Autogroups on file write
    augroup("FileMod", { clear = true })

    autocmd("BufWritePre", {
        group = "FileMod",
        desc = "remove trailing whitespace on write.",
        command = ":%s/\\s\\+$//e"
    })

    -- Autogroups which make vim prettier
    augroup("VisualFX", { clear = true })

    autocmd("TextYankPost", {
        group = "VisualFX",
        desc = "highlight on yanking text.",
        callback = function()
            vim.highlight.on_yank()
        end
    })
end

return M
