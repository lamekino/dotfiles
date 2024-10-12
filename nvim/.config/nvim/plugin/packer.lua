local _, packer = pcall(require, "packer")
local _, util = pcall(require, "packer.util")

local install_path =
    vim.fn.stdpath("data")
    .. "/site/pack/packer/start/packer.nvim"

local has_packer = vim.fn.empty(vim.fn.glob(install_path))

-- download packer on initial run
if not has_packer then
    vim.fn.system {
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
    -- this package manager
    use { "wbthomason/packer.nvim" }

    -- swap surrounding parens/brackets/etc
    use { "tpope/vim-surround" }

    -- explore file changes
    use { "mbbill/undotree" }

    -- keybindings for commenting
    use { "numToStr/Comment.nvim" }

    -- status bar
    use { "nvim-lualine/lualine.nvim" }

    -- renders color codes
    use { "norcalli/nvim-colorizer.lua" }

    -- the colorscheme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- highlights code messages
    use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim", }

    -- fuzzy finder
    use { "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" }

    -- syntax parser
    use { "nvim-treesitter/nvim-treesitter", run = vim.cmd.TSUpdate }


    -- git interface
    use { "TimUntersberger/neogit",
        config = function()
        end,
        requires = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim"
        }
    }

    -- lsp + completion
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = function() pcall(vim.cmd, 'MasonUpdate') end,
            },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "saadparwaiz1/cmp_luasnip" },
            { "ray-x/lsp_signature.nvim" },
            { 'L3MON4D3/LuaSnip' },
            { 'mfussenegger/nvim-jdtls' } -- optional
        }
    }

    -- sync the packages to finish setup
    if not has_packer then
        packer.sync()
    end
end)
