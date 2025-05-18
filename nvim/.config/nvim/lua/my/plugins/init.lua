local M = {}

function M.plugins(cfg)
    return {
        -- the colorscheme
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000, -- load this first
            config = function()
                require("my.colorscheme").setup(cfg.colormode)
            end
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
                    '*',
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
            opts = {
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
            }
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

        -- language servers
        {
            -- config
            "neovim/nvim-lspconfig",
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            -- utils
            "ray-x/lsp_signature.nvim",
            "mfussenegger/nvim-jdtls",
            config = function()
                require("my.lspconfig").setup()
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

function M:setup(cfg)
    -- this is required to be set here
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"

    local is_installed = require("my.plugins.bootstrap").run()

    if is_installed then
        local plugins = self.plugins(cfg)
        plugins.ui = require("my.plugins.ui")

        require("lazy").setup(plugins)
    end
end

return M
