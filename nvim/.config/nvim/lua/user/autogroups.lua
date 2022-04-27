-- vim autogroups
-- Startup {{{
local startup_group = vim.api.nvim_create_augroup("NeovimStartup", {
        clear = true
    })

-- SourcePost sets the background faster but i don't know the implications of
-- that
vim.api.nvim_create_autocmd("VimEnter", {
        desc = "make background transparent on startup.",
        group = startup_group,
        callback = function ()
            vim.api.nvim_set_hl(0, "Normal", {
                    ctermbg = NONE,
                    guibg = NONE
                })
        end,
    })

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
-- }}}
-- File modifiers: {{{
local file_mod_group = vim.api.nvim_create_augroup("FileMod", {
        clear = true
    })

vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "remove trailing whitespace on write.",
        group = file_mod_group,
        command = ":%s/\\s\\+$//e"
    })
-- }}}
-- Visual Improvements: {{{
local vfx_group = vim.api.nvim_create_augroup("VisualFX", {
        clear = true
    })

vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "highlight on yanking text.",
        group = vfx_group,
        callback = function ()
            vim.highlight.on_yank()
        end
    })
-- }}}
-- vim:foldmethod=marker
