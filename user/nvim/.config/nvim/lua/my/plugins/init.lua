local M = {}

local my_icons = {
    cmd = "⌘",
    config = "🛠",
    event = "📅",
    ft = "📂",
    init = "⚙",
    keys = "🗝",
    plugin = "🔌",
    runtime = "💻",
    require = "🌙",
    source = "📄",
    start = "🚀",
    task = "📌",
    lazy = "💤 ",
}

local function my_plugin_configs(cfg)
    return {
        -- lazy config
        ui = { icons = my_icons, },

        -- colorscheme
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000, -- load this first
            config = function()
                require("my.colorscheme").setup(cfg.colormode)
            end
        },

        {
            "wtfox/jellybeans.nvim",
            lazy = false,
            priority = 1000
        },

        -- swap surrounding parens/brackets/etc
        "tpope/vim-surround",

        -- explore file changes
        "mbbill/undotree",

        -- keybindings for commenting
        {
            "numToStr/Comment.nvim",
            opts = {}
        },

        -- status bar
        {
            "nvim-lualine/lualine.nvim",
            config = function()
                require("my.plugins.config.lualine").setup()
            end
        },

        -- renders color codes
        {
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("colorizer").setup(nil, {
                    "*",
                    names = false,
                })
            end
        },

        -- highlights code messages
        {
            "folke/todo-comments.nvim",
            dependencies = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup {
                    signs = false,
                    highlight = {
                        before = "",
                        keyword = "fg",
                        after = "",
                    }
                }
            end
        },

        -- fuzzy finder
        {
            "nvim-telescope/telescope.nvim",
            dependencies = "nvim-lua/plenary.nvim",
            config = function()
                require("my.plugins.config.telescope").setup()
            end
        },

        -- syntax parser
        {
            "nvim-treesitter/nvim-treesitter",
            build = vim.cmd.TSUpdate,
            config = function()
                require("my.plugins.config.treesitter"):setup()
            end
        },


        -- git manager
        {
            "TimUntersberger/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim"
            },
            config = function()
                require("my.plugins.config.neogit").setup()
            end
        },

        -- lsp config
        {
            "neovim/nvim-lspconfig",
            "ray-x/lsp_signature.nvim",
            "mfussenegger/nvim-jdtls",
            config = function()
                require("my.lspconfig").setup()
            end
        },

        -- lsp manager
        {
            -- config
            "mason-org/mason.nvim",

            dependencies = { "mason-org/mason-lspconfig.nvim" },
            config = function()
                require("my.plugins.config.mason")
            end
        },

        -- autocomplete + code snippets
        {
            "hrsh7th/nvim-cmp",

            dependencies = {
                {
                    "L3MON4D3/LuaSnip",
                    version = "v2.*",
                    build = "make install_jsregexp"

                },
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "saadparwaiz1/cmp_luasnip",
            },

            config = function()
                require("my.plugins.config.cmp")
                require("my.snippets").setup()
            end
        }
    }
end

function M.setup(cfg)
    -- these are required to be set here
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"

    if require("my.plugins.bootstrap").start() then
        require("lazy").setup(my_plugin_configs(cfg))
    end
end

return M
