local okay, neogit = pcall(require, "neogit")
if not okay then return end

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
    desc = "set the cwd to the git project's root",
    group = neogit_group,
    callback = function()
        local git_root = neogit.cli.git_root()
        if (string.len(git_root) <= 0) then
            return
        end

        if (string.len(vim.fn.chdir(git_root)) <= 0) then
            vim.api.nvim_err_writeln("error: could not change to git root: "
                .. git_root)
        end
    end
})
