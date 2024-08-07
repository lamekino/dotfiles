local packer = require("packer")
local util = require("packer.util")

-- Bootstrap on a clean install
local install_path =
    vim.fn.stdpath("data")
    .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    }
end

-- backup before an update
vim.api.nvim_create_user_command("PackerUpgrade", function()
    packer.snapshot(tostring(os.time()))
    packer.update()
end, { ["bang"] = true })

-- use a floating window
packer.init {
    compile_path = util.join_paths(
        vim.fn.stdpath('config'),
        'plugin',
        '__packer_compiled.lua'
    ),
    display = {
        open_fn = function()
            return util.float { border = "rounded" }
        end,
    },
}

packer.startup(function(use)
    -- the package manager
    use { "wbthomason/packer.nvim" }

    -- neat plugins (vim script)
    use { "tpope/vim-surround" }
    use { "mbbill/undotree" }

    -- neat plugins (lua script)
    use { "numToStr/Comment.nvim" }
    use { "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    }

    -- Fuzzy finding
    use { "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/plenary.nvim"
    }

    -- Git support
    use { "TimUntersberger/neogit",
        config = function()
        end,
        requires = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim"
        }
    }

    -- All the lsp stuff
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "saadparwaiz1/cmp_luasnip" },
            { "ray-x/lsp_signature.nvim" },
            { 'L3MON4D3/LuaSnip' },

            -- Java
            { 'mfussenegger/nvim-jdtls' }
        }
    }

    -- treesitter
    use { "nvim-treesitter/nvim-treesitter",
        run = vim.cmd.TSUpdate
    }

    -- appearance stuff
    use { "nvim-lualine/lualine.nvim" }
    use { "norcalli/nvim-colorizer.lua" }
    use { "catppuccin/nvim", as = "catppuccin" }

    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
