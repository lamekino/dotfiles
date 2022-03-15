-- sets the keymaps

local function mapper(mode, opts)
    return function (from, to, bufnr)
        bufnr = bufnr or 0
        vim.api.nvim_buf_set_keymap(bufnr, mode, from, to, opts)
    end
end

local K = {
    nnoremap   = mapper("n", { noremap = true }),
    inoremap   = mapper("i", { noremap = true }),
    vnoremap   = mapper("v", { noremap = true }),
    map = mapper("", { silent = true }),
    imap = mapper("i", { silent = true })
}

-- Hide highlight
K.nnoremap(";", ":noh<cr>")
-- Delete to void
K.nnoremap("_", "\"_d")
-- Yank to end like D
K.nnoremap("Y", "y$")

-- Function keys
-- TODO: Make this pure lua
-- disable the F1 for help
K.imap("<F1>", "<C-o>:echo<CR>")
K.nnoremap("<F5>", ":so $MYVIMRC<cr>")

-- Leader keys
K.map('<Space>', '<Nop>')
vim.g.mapleader = " "
K.nnoremap("<Leader><Leader>", ":bd<cr>")
K.nnoremap("<Leader>a", ":copen<cr>")
K.nnoremap("<Leader>s", ":Telescope buffers<cr>")
K.nnoremap("<Leader>d", ":Lex<cr>")
K.nnoremap("<Leader>f", ":Telescope find_files<cr>")

-- Moving through quickfix
K.nnoremap("<Leader>j", ":cnext<cr>")
K.nnoremap("<Leader>k", ":cprev<cr>")

-- Git
K.nnoremap("<Leader>gg", ":Git ")
-- Commits
K.nnoremap("<Leader>ga", ":Git commit % -m ''<Left>")
-- Staging
K.nnoremap("<Leader>gs", ":Git status<cr>")
K.nnoremap("<Leader>gd", ":Git diff<cr>")
K.nnoremap("<Leader>g;", ":Git diff ORIG_HEAD HEAD<cr>")
-- Remote
K.nnoremap("<Leader>gl", ":Git log<cr>")
K.nnoremap("<Leader>gp", ":Git pull<cr>")
K.nnoremap("<Leader>gP", ":Git push<cr>")

-- Toggle options
K.nnoremap("<Leader>tr", ":set ro!<cr>")
K.nnoremap("<Leader>tw", ":set wrap!<cr>")
K.nnoremap("<Leader>tp", ":set paste!<cr>")
K.nnoremap("<Leader>ts", ":set spell!<cr>")

-- Build
K.nnoremap("<Leader>1", ":w<cr>:make<cr>")

-- Control keys
-- Move blocks of text around
K.vnoremap("<C-j>", ":m '>+1<cr>gv=gv")
K.vnoremap("<C-k>", ":m '<-2<cr>gv=gv")


-- Splits/Buffers
K.nnoremap("<C-h>", ":bprev!<cr>")
K.nnoremap("<C-l>", ":bnext!<cr>")

-- Copy/paste
K.nnoremap("<C-y><C-y>", "\"+y$")
K.nnoremap("<C-y>", "\"+y")
K.nnoremap("<C-p>", "\"+p")
