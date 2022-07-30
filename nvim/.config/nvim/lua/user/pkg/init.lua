require("user.pkg.packer")
require("user.pkg.treesitter")
require("user.pkg.lualine")

require("colorizer").setup {
    "*",
    css = { rgb_fn = true },
}

require("todo-comments").setup {
    signs = false,
    highlight = {
        before = "",
        keyword = "fg",
        after = "fg",
    }
}

require("diffview").setup {
    use_icons = false
}

require("neogit").setup {
    kind = "split",
    disable_signs = true,
    integrations = {
        diffview = true
    }
}

require("Comment").setup()
