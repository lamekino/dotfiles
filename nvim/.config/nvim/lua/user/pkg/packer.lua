-- Useful Plugins
local packer = require("packer")

-- Bootstrap on a clean install
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
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

    -- neat plugins
    use { "vim-scripts/Align" }      -- Aligns whitespace
    use { "danro/rename.vim" }       -- Rename files from buffer
    use { "tpope/vim-commentary" }   -- Treat comments like text objects
    use { "tpope/vim-surround" }     -- Modify surrounding characters
    use { "tpope/vim-fugitive" }     -- Git support
    use { "mhinz/vim-startify" }     -- Useful startup screen
    use { "godlygeek/tabular" }
    use { "nvim-telescope/telescope.nvim", -- better than fzf.vim
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- lsp
    use { "williamboman/nvim-lsp-installer" }
    use { "neovim/nvim-lspconfig" }
    use { "ray-x/lsp_signature.nvim" }

    -- completion
    use { "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }

    -- snip engine
    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate" }

    -- language support
    use { "sheerun/vim-polyglot" }
    use { "alx741/vim-hindent" }
    use { "uiiaoo/java-syntax.vim" }


    -- appearance stuff
    use { "nvim-lualine/lualine.nvim" }
    use { "norcalli/nvim-colorizer.lua" }

    -- colorscheme hoarding
    use { "drewtempelmeyer/palenight.vim",
        disable = true }
    use { "folke/tokyonight.nvim",
        disable = false }
    use { "catppuccin/nvim", as = "catppuccin",
        disable = true }
    use { "ellisonleao/gruvbox.nvim",
        disable = false }
    use { "joshdick/onedark.vim",
        disable = true }

    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
