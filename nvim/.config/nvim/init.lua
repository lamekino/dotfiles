-- line numbers
vim.o.number         = true
vim.o.relativenumber = true
vim.o.numberwidth    = 4
-- editor settings
vim.opt.colorcolumn  = "80"
vim.o.confirm        = true
vim.o.ignorecase     = true
vim.o.hidden         = true
vim.o.cursorline     = true
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.list           = true
vim.o.wrap           = false
vim.o.listchars      = "tab:--,space:·,trail:×,nbsp:*,extends:$"
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
vim.o.encoding       = "utf-8"
vim.o.fileformat     = "unix"
vim.api.nvim_create_autocmd("VimEnter", {
    desc = "gets misc options to set on startup",
    callback = function()
        vim.o.fo = vim.o.fo:gsub("o", "")
        vim.o.termguicolors = true
    end
})

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
-- vim.g.netrw_liststyle = 3
vim.g.netrw_banner  = false

-- windows host options
if not vim.fn.has("unix") and vim.fn.has("win32") then
    vim.o.shell        = "pwsh.exe"
    vim.o.shellcmdflag = "-Command"
    vim.o.shellquote   = ""
    vim.o.shellxquote  = ""
end
