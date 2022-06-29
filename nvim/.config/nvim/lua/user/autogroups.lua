local M = {}
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

M.setup = function()
    local terminal_group = augroup("Terminal", { clear = true })

    autocmd("TermOpen", {
        desc = "remove line numbers from terminal",
        group = terminal_group,
        callback = function()
            vim.opt_local.rnu = false
            vim.opt_local.nu  = false
        end
    })

    local file_mod_group = augroup("FileMod", { clear = true })

    autocmd("BufWritePre", {
        desc = "remove trailing whitespace on write.",
        group = file_mod_group,
        command = ":%s/\\s\\+$//e"
    })

    local vfx_group = augroup("VisualFX", { clear = true })

    autocmd("TextYankPost", {
        desc = "highlight on yanking text.",
        group = vfx_group,
        callback = function()
            vim.highlight.on_yank()
        end
    })
end

return M
