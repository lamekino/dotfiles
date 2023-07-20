local okay, treesitter = require("nvim-treesitter.configs")
if not okay or treesitter == nil then return end

treesitter.setup {
    sync_install = false,
    ensure_installed = {
        "java", "c", "cpp", "bash", "python", "haskell", "rust",
        "lua", "vim", "help"
    },
    highlight = {
        enable = true,
        disable = { "markdown" },
        additional_vim_regex_highlighting = false,
    }
}
