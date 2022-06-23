-- vim autogroups
local M = {}

-- FIXME: this is the dumb way, fix this
M.setup = function()
    -- local startup_group = vim.api.nvim_create_augroup("NeovimStartup", {
    --         clear = true
    --     })

    -- vim.api.nvim_create_autocmd("VimEnter", {
    --         desc = "make background transparent on startup.",
    --         group = startup_group,
    --         callback = function ()
    --             if not vim.fn.exists("g:GuiLoaded") then
    --                 vim.api.nvim_set_hl(0, "Normal", {
    --                         ctermbg = NONE,
    --                         guibg = NONE
    --                     })
    --             end
    --         end,
    --     })

    -- vim.api.nvim_create_autocmd("SourcePost", {
    --         desc = "set LSP colors for side bar.",
    --         group = startup_group,
    --         callback = function ()
    --             vim.api.nvim_set_hl(0, "Normal", {
    --                     ctermbg = NONE,
    --                     guibg = NONE
    --                 })
    --         end
    --     })
    local terminal_group = vim.api.nvim_create_augroup("Terminal", {
        clear = true
    })

    vim.api.nvim_create_autocmd("TermOpen", {
            desc = "remove line numbers from terminal",
            group = terminal_group,
            callback = function ()
                vim.api.nvim_win_set_option(0, "nu", false)
                vim.api.nvim_win_set_option(0, "rnu", false)
            end
        })

    local file_mod_group = vim.api.nvim_create_augroup("FileMod", {
        clear = true
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "remove trailing whitespace on write.",
        group = file_mod_group,
        command = ":%s/\\s\\+$//e"
    })

    local vfx_group = vim.api.nvim_create_augroup("VisualFX", {
        clear = true
    })

    vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "highlight on yanking text.",
        group = vfx_group,
        callback = function()
            vim.highlight.on_yank()
        end
    })
end

return M
