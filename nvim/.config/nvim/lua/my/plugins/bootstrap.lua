local M = {}

function M.run()
    local repo = "https://github.com/folke/lazy.nvim.git"
    local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not (vim.uv or vim.loop).fs_stat(path) then
        local git_output = vim.fn.system({
            "git", "clone", "--filter=blob:none", "--branch=stable", repo, path
        })

        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { git_output,                     "WarningMsg" }
            }, true, {})

            vim.fn.getchar()
            return false
        end
    end

    vim.opt.rtp:prepend(path)
    return true
end

return M
