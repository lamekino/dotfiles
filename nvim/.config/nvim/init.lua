-- init.lua --
local set    = vim.o
local global = vim.g

-- idk why this has to be right here but it does
set.termguicolors  = true

require("pkg-config")
require("vim-config")
require("lsp-config")

-- basic editor options
set.nu             = true
set.rnu            = true
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
set.list           = true
set.listchars      = "tab:| ,space:·,trail:×,nbsp:*"
set.guicursor      = ""
set.path           = set.path .. "**"
global.netrw_winsize   = 15
global.netrw_liststyle = 3
global.netrw_banner    = false
