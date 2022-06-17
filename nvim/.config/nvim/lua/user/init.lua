-- init.lua --
local set    = vim.o
local global = vim.g
local has    = vim.fn.has

set.termguicolors  = true

require("user.pkg")
require("user.lsp")
require("user.colorscheme").setup("jellybeans-nvim", "dark")
require("user.autogroups").setup()
require("user.keybinds").setup()

-- basic editor options
set.nu             = true
set.rnu            = true
set.nuw            = 6
set.confirm        = true
set.ignorecase     = true
set.lazyredraw     = true
set.hidden         = true
set.cursorline     = true
set.splitbelow     = true
set.splitright     = true
set.expandtab      = true
set.tabstop        = 4
set.shiftwidth     = 4
set.softtabstop    = 4
set.laststatus     = 3
set.list           = true
set.listchars      = "tab:| ,space:·,trail:×,nbsp:*"
set.guicursor      = ""
set.swapfile       = false
set.undofile       = true
set.undodir        = vim.fn.stdpath("cache") .. "/undodir"
set.path           = set.path .. "**"
set.fileencoding   = "utf-8"
set.fileformat     = "unix"
global.netrw_winsize   = 15
global.netrw_liststyle = 3
global.netrw_banner    = false

if has("mouse") then
    set.mouse = "vn"
end
