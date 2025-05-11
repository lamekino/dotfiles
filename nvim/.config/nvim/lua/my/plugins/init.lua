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
        "numToStr/Comment.nvim",

        -- status bar
        "nvim-lualine/lualine.nvim",

        -- renders color codes
        "norcalli/nvim-colorizer.lua",

        -- highlights code messages
        {
            "folke/todo-comments.nvim",
            dependencies = "nvim-lua/plenary.nvim"
        },

        -- fuzzy finder
        {
            "nvim-telescope/telescope.nvim",
            dependencies = "nvim-lua/plenary.nvim"
        },

        -- syntax parser
        {
            "nvim-treesitter/nvim-treesitter",
            build = vim.cmd.TSUpdate
        },


        -- git manager
        {
            "TimUntersberger/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim"
            }
        },

        -- lsp manager
        {
            'williamboman/mason.nvim',
            build = 'MasonUpdate'
        },

        -- lsp + completion
        -- TODO: remove this,
        -- https://lsp-zero.netlify.app/blog/theprimeagens-config-from-2022.html
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v2.x',
            dependencies = {
                { 'neovim/nvim-lspconfig' },
                { 'williamboman/mason-lspconfig.nvim' },
                { 'hrsh7th/nvim-cmp' },
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
    }
end

local function bootstrap()
    local repo = "https://github.com/folke/lazy.nvim.git"
    local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not (vim.uv or vim.loop).fs_stat(path) then
        local git_output = vim.fn.system({
            "git", "clone", "--filter=blob:none", "--branch=stable", repo, path
        })

        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { git_output,                     "WarningMsg" }
            }, true, {})

            vim.fn.getchar()
            return false
        end
    end

    vim.opt.rtp:prepend(path)
    return true
end

function M:setup(cfg)
    -- this is required to be set here
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"

    if bootstrap() then
        require("lazy").setup(self.plugins(cfg))
    end
end

return M
