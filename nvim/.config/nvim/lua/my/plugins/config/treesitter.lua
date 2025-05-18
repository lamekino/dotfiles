local M = {}

M.config = {
    sync_install = false,
    ensure_installed = {
        "java",
        "c",
        "cpp",
        "bash",
        "python",
        "haskell",
        "lua",
        "vim",
        "vimdoc",
        "markdown"
    },
    highlight = {
        enable = true,
        -- disable = { "markdown" },
        additional_vim_regex_highlighting = false,
    }
}


function M:setup()
    require("nvim-treesitter.configs").setup(self.config)
end

return M
