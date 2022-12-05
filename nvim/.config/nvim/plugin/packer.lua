local packer = require("packer")
local util = require("packer.util")

-- Bootstrap on a clean install
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    }
end

-- use a floating window
packer.init {
    compile_path = util.join_paths(
        vim.fn.stdpath('config'),
        'plugin',
        '__compiled.lua'
    ),
    display = {
        open_fn = function()
            return util.float { border = "rounded" }
        end,
    },
}

-- TODO: refactor `config = ...` to lua/user/pkg
packer.startup(function(use)
    -- the package manager
    use { "wbthomason/packer.nvim" }

    -- neat plugins (vim script)
    use { "tpope/vim-surround" }
    use { "mbbill/undotree" }

    -- neat plugins (lua script)
    use { "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    }
    use { "rafcamlet/nvim-luapad" }
    use { "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup()
        end
    }
    use { "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/plenary.nvim"
    }
    use { "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                signs = false,
                highlight = {
                    before = "",
                    keyword = "fg",
                    after = "fg",
                }
            }

        end
    }
    use { "nvim-lua/plenary.nvim",
        config = function()
            require("diffview").setup {
                use_icons = false
            }
        end
    }
    use { "TimUntersberger/neogit",
        config = function()
            require("neogit").setup {
                kind = "split",
                disable_signs = true,
                integrations = {
                    diffview = true
                }
            }
        end,
        requires = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim"
        }
    }

    -- lsp
    use {
        "neovim/nvim-lspconfig",   -- obligatory
        "williamboman/mason.nvim", -- replaces nvim-lsp-installer
        "williamboman/mason-lspconfig.nvim", -- ^
        "ray-x/lsp_signature.nvim" -- shows function arguments while typing
    }

    -- completion
    use {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
    }

    -- snip engine
    use { "L3MON4D3/LuaSnip" }
    use { "saadparwaiz1/cmp_luasnip" }

    -- treesitter
    use { "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                sync_install = false,
                ensure_installed = {
                    "java", "c", "cpp", "bash", "python", "haskell", "rust",
                    "lua", "vim"
                },
                highlight = {
                    enable = true,
                    disable = { "markdown" },
                    additional_vim_regex_highlighting = false,
                }
            }
        end
    }

    -- language support
    use { "sheerun/vim-polyglot" }
    use { "uiiaoo/java-syntax.vim" }


    -- appearance stuff
    use { "nvim-lualine/lualine.nvim",
        config = function()
            local section = require("user.lualine.sections")

            require("lualine").setup {
                options = {
                    icons_enabled = false,
                    component_separators = {
                        left  = "│",
                        right = "│"
                    },
                    section_separators = {
                        left  = "▓▒░",
                        right = "░▒▓"
                    },
                },

                sections = {
                    lualine_a = section.a,
                    lualine_b = section.b,
                    lualine_c = section.c,
                    lualine_x = section.x,
                    lualine_y = section.y,
                    lualine_z = section.z,
                }
            }
        end
    }
    use { "norcalli/nvim-colorizer.lua",
        config = function()
            -- FIXME: why is this giving an LSP warning?
            require("colorizer").setup {
                "*",
                css = { rgb_fn = true },
            }
        end
    }

    -- colorscheme
    use { "rebelot/kanagawa.nvim" }
    use { "savq/melange" }

    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
