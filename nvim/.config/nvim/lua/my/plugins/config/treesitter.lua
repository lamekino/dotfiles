local M = {}

M.config = {
    sync_install = false,
    ensure_installed = {
        "bash", "c", "cpp", "haskell", "java", "lua", "markdown", "python",
        "vim", "vimdoc",
    },
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
    }
}


function M:setup()
    require("nvim-treesitter.configs").setup(self.config)
end

return M
