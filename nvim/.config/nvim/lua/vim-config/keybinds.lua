-- set the keymaps
local set    = vim.o
local global = vim.g
local api    = vim.api
local fn     = vim.fn

local key = {
    norm = function(from, to)
        api.nvim_set_keymap("n", from, to, { noremap = true })
    end,
    visual = function(from, to)
        api.nvim_set_keymap("v", from, to, { noremap = true })
    end,
    insert = function(from, to)
        api.nvim_set_keymap("i", from, to, { noremap = true })
    end,
}


if fn.has("mouse") then
    set.mouse = "vn"
end

-- Hide highlight
key.norm(";", ":noh<cr>")
-- Delete to void
key.norm("_", "\"_d")
-- Yank to end like D
key.norm("Y", "y$")

-- Function keys
-- TODO: Make this pure lua
vim.cmd [[
imap     <F1> <C-o>:echo<CR>
" https://vim.fandom.com/wiki/Remove_unwanted_spaces
nnoremap <F1>
            \ m0
            \ :let _s=@/ <Bar>
            \ :%s/\s\+$//e <Bar>
            \ : let @/=_s <Bar>
            \ :nohl <Bar>
            \ :unlet _s <CR>
            \ '0
            \ :echo "Trailing spaces removed"<cr>
nnoremap <F2>
            \ m0
            \ gg=G
            \ '0
            \ :echo "Fixed indentation"<cr>
]]
key.norm("<F5>", ":so $MYVIMRC<cr>")

-- Leader keys
-- vim.cmd[[nnoremap <Space> <Nop>]]
api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
global.mapleader = " "
key.norm("<Leader><Leader>", ":bd<cr>")
key.norm("<Leader>a", ":copen<cr>")
key.norm("<Leader>s", ":Telescope buffers<cr>")
key.norm("<Leader>d", ":Lex<cr>")
key.norm("<Leader>f", ":Telescope find_files<cr>")

-- Moving through quickfix
key.norm("<Leader>j", ":cnext<cr>")
key.norm("<Leader>k", ":cprev<cr>")

-- Git
key.norm("<Leader>gg", ":Git ")
key.norm("<Leader>ga", ":Git commit % -m ''<Left>")
key.norm("<Leader>gs", ":Git status<cr>")
key.norm("<Leader>gd", ":Git diff ORIG_HEAD HEAD<cr>")
key.norm("<Leader>gl", ":Git log<cr>")
key.norm("<Leader>gp", ":Git pull<cr>")
key.norm("<Leader>gP", ":Git push<cr>")

-- Toggle options
key.norm("<Leader>tr", ":set ro!<cr>")
key.norm("<Leader>tw", ":set wrap!<cr>")
key.norm("<Leader>tp", ":set paste!<cr>")
key.norm("<Leader>ts", ":set spell!<cr>")

-- Build
key.norm("<Leader>1", ":w<cr>:make<cr>")

-- Control keys
-- Move blocks of text around
key.visual("<C-j>", ":m '>+1<cr>gv=gv")
key.visual("<C-k>", ":m '<-2<cr>gv=gv")


-- Splits/Buffers
key.norm("<C-h>", ":bprev!<cr>")
key.norm("<C-l>", ":bnext!<cr>")

-- Copy/paste
key.norm("<C-y><C-y>", "\"+y$")
key.norm("<C-y>", "\"+y")
key.norm("<C-p>", "\"+p")
