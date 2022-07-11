-- line numbers
vim.o.number         = true
vim.o.relativenumber = true
vim.o.numberwidth    = 6
-- editor settings
vim.o.confirm        = true
vim.o.ignorecase     = true
vim.o.hidden         = true
vim.o.cursorline     = true
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.list           = true
vim.o.listchars      = "tab:| ,space:·,trail:×,nbsp:*"
vim.o.guicursor      = ""
-- tab settings
vim.o.expandtab      = true
vim.o.tabstop        = 4
vim.o.shiftwidth     = 4
vim.o.softtabstop    = 4
-- backup files
vim.o.swapfile       = false
vim.o.undofile       = true
vim.o.undodir        = vim.fn.stdpath("cache") .. "/undodir"
-- misc
vim.o.termguicolors  = true
vim.o.lazyredraw     = true
vim.o.path           = vim.o.path .. "**"
vim.o.fileencoding   = "utf-8"
vim.o.fileformat     = "unix"

-- mouse support in normal and visual
if vim.fn.has("mouse") then
    vim.o.mouse = "vn"
end

-- single status bar
if vim.v.version >= 700 then
    vim.o.laststatus = 3
end

-- remove unneeded space
if vim.v.version >= 800 then
    vim.o.cmdheight = 0
end

-- global variables
vim.g.netrw_winsize   = 15
vim.g.netrw_liststyle = 3
vim.g.netrw_banner    = false

-- Set the shell to Powershell 7 when on windows host
if not vim.fn.has("unix") and vim.fn.has("win32") then
    vim.o.shell = "pwsh.exe"
    vim.o.shellcmdflag = "-Command"
    vim.o.shellquote = ""
    vim.o.shellxquote = ""
end

require("user.autogroups").setup()
require("user.colors").setup("jellybeans-nvim", "dark")
require("user.keybinds").setup()
require("user.pkg")
require("user.lsp")
