local M = {}
local neogit = require("neogit")

local function cd_git_root()
    local git_root = neogit.cli.worktree_root(vim.fn.getcwd())

    if git_root == nil or string.len(git_root) <= 0 then
        return
    end

    if string.len(vim.fn.chdir(git_root)) <= 0 then
        error("error: could not change to git root: " .. git_root)
    end
end

function M.setup()
    neogit.setup {
        kind = "split",
        disable_signs = true,
        integrations = {
            diffview = true
        }
    }

    local neogit_group = vim.api.nvim_create_augroup("Neogit", {
        clear = true
    })


    vim.api.nvim_create_autocmd("VimEnter", {
        callback = cd_git_root,
        desc = "set the cwd to the git project's root",
        group = neogit_group,
    })

    vim.api.nvim_create_user_command("GitRootCd", cd_git_root, {
        bang = true
    })
end

return M
