-- Useful Plugins
local packer = require("packer")

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
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

return packer.startup(function(use)
    -- the package manager
    use { "wbthomason/packer.nvim" }

    -- neat plugins (vim script)
    use { "tpope/vim-fugitive" }
    use { "tpope/vim-surround" }
    use { "mbbill/undotree" }
    use { "danro/rename.vim" }

    -- neat plugins (lua script)
    use { "numToStr/Comment.nvim" }
    use { "rafcamlet/nvim-luapad" }
    use { "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/plenary.nvim"
    }
    use { "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim"
    }
    -- TODO: move to this from vim-fugitive
    use { "TimUntersberger/neogit",
        requires = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim"
        }

    }

    -- lsp
    use { "williamboman/nvim-lsp-installer" }
    use { "neovim/nvim-lspconfig" }
    use { "ray-x/lsp_signature.nvim" }

    -- completion
    use { "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/cmp-path" }
    use { "hrsh7th/cmp-cmdline" }

    -- snip engine
    use { "L3MON4D3/LuaSnip" }
    use { "saadparwaiz1/cmp_luasnip" }

    -- treesitter
    use { "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }

    -- language support
    use { "sheerun/vim-polyglot" }
    use { "uiiaoo/java-syntax.vim" }


    -- appearance stuff
    use { "nvim-lualine/lualine.nvim" }
    use { "norcalli/nvim-colorizer.lua" }

    -- colorschemes
    use { "metalelf0/jellybeans-nvim", requires = { "rktjmp/lush.nvim" } }
    use { "folke/tokyonight.nvim" }
    use { "rebelot/kanagawa.nvim" }

    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
