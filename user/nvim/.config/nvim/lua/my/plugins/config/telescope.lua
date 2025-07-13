local M = {}
local telescope = require("telescope")

function M.setup()
    telescope.setup({
        defaults = {
            layout_strategy = "horizontal",
        },
        pickers = {
            find_files = {
                theme = "ivy"
            },
            git_files = {
                hidden = true,
            },
            live_grep = {
                hidden = true,
            },
        }
    })

    -- fix for winborder in nvim 0.11
    -- https://github.com/nvim-telescope/telescope.nvim/issues/3436#issuecomment-2756267300
    vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopeFindPre",
        callback = function()
            local origborder = vim.o.winborder

            vim.opt_local.winborder = "none"
            vim.api.nvim_create_autocmd("WinLeave", {
                once = true,
                callback = function()
                    vim.opt_local.winborder = origborder
                end,
            })
        end,
    })
end

return M
