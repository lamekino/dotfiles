VIM_COLORMODE = os.getenv("VIM_COLORMODE") or "dark"

-- install/load plugins
require("my.plugins").setup({ colormode = VIM_COLORMODE })

-- start lsp
require("my.lspconfig").setup()

-- configure diagnostics
require("my.diagnostics").setup(VIM_COLORMODE)

-- line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 5

-- ui
vim.o.guicursor = ""
vim.opt.colorcolumn = "80"
vim.o.winborder = "single"
vim.o.listchars = "tab:| ,space:·,trail:×,nbsp:*,extends:$"
vim.o.list = true
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wrap = false

-- buffer
vim.o.hidden = true
vim.o.confirm = true

-- search
vim.o.ignorecase = true

-- tab settings
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- backup files
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("cache") .. "/undodir"

-- misc
vim.o.termguicolors = true
vim.o.lazyredraw = true
vim.o.path = vim.o.path .. "**"

-- mouse support in normal and visual
if vim.fn.has("mouse") then
    vim.o.mouse = "vn"
    vim.o.mousemodel = "extend"
end

-- single status bar
if vim.fn.has("nvim-0.7.2") then
    vim.o.laststatus = 3
end

-- global variables
vim.g.netrw_winsize = 15
vim.g.netrw_banner = false
vim.g.mapleader = " "

-- set values on vim startup
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.o.formatoptions = vim.o.formatoptions:gsub("o", "")
        vim.o.termguicolors = true
    end
})
