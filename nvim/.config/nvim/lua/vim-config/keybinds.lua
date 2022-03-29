-- sets the keymaps

local function create_mapper(mode, opts)
    return function (from, to, bufnr)
        bufnr = bufnr or 0
        vim.api.nvim_buf_set_keymap(bufnr, mode, from, to, opts)
    end
end

local K = {
    map  = create_mapper("", { silent = true }),
    imap = create_mapper("i", { silent = true }),
    nnoremap = create_mapper("n", { noremap = true }),
    inoremap = create_mapper("i", { noremap = true }),
    vnoremap = create_mapper("v", { noremap = true })
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
K.nnoremap("<Leader>gf", ":Telescope git_files<cr>")
-- Commits
K.nnoremap("<Leader>ga", ":Git commit<cr>") -- commit what is staged
K.nnoremap("<Leader>gs", ":Git<cr>")        -- git status & stager
K.nnoremap("<Leader>gc", ":Git commit %")   -- commit working file
-- Staging
K.nnoremap("<Leader>gd", ":Git diff %<cr>")
K.nnoremap("<Leader>gD", ":Git diff<cr>")
K.nnoremap("<Leader>g;", ":Git diff ORIG_HEAD HEAD<cr>")
-- Remote
K.nnoremap("<Leader>gl", ":Git log<cr>")
K.nnoremap("<Leader>gp", ":Git pull<cr>")

-- Toggle options
K.nnoremap("<Leader>tr", ":set ro!<cr>")
K.nnoremap("<Leader>tw", ":set wrap!<cr>")
K.nnoremap("<Leader>tp", ":set paste!<cr>")
K.nnoremap("<Leader>ts", ":set spell!<cr>")

-- Build
K.nnoremap("<F1>", ":w<cr>:make<cr>")

-- Control keys
-- Move blocks of text around
K.vnoremap("<C-j>", ":m '>+1<cr>gv=gv")
K.vnoremap("<C-k>", ":m '<-2<cr>gv=gv")
-- Window exit
K.nnoremap("<C-q>", "<C-w>q")


-- Splits/Buffers
K.nnoremap("<C-h>", ":bprev!<cr>")
K.nnoremap("<C-l>", ":bnext!<cr>")

-- Copy/paste
K.nnoremap("<C-y><C-y>", "\"+y$")
K.nnoremap("<C-y>", "\"+y")
K.nnoremap("<C-p>", "\"+p")
