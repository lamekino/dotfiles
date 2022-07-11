-- sets the keymaps
local M = {}

local function create_mapper(mode, opts)
    return function(keys, func)
        vim.keymap.set(mode, keys, func, opts)
    end
end

M.setup = function()
    local k = {
        map      = create_mapper("", { silent = true }),
        imap     = create_mapper("i", { silent = true }),
        nmap     = create_mapper("n", { silent = true }),
        nnoremap = create_mapper("n", { noremap = true }),
        inoremap = create_mapper("i", { noremap = true }),
        vnoremap = create_mapper("v", { noremap = true }),
        tnoremap = create_mapper("t", { noremap = true })
    }

    -- Set leader key
    k.map('<Space>', '<Nop>')
    vim.g.mapleader = " "

    -- Splits
    k.map("s", "<nop>")
    k.nnoremap("ss", ":vsp<CR>")
    k.nnoremap("sd", ":sp<CR>")
    k.nnoremap("sp", ":bprev!<cr>")
    k.nnoremap("sn", ":bnext!<cr>")

    -- Delete to void
    k.nnoremap("_", "\"_d")
    -- Yank to end like D
    k.nnoremap("Y", "y$")

    -- Function Keys
    k.imap("<F1>", "") -- disable the F1 for help

    -- Leader keys
    k.nnoremap("<Leader>a", ":copen<cr>")
    k.nnoremap("<Leader>s", ":Telescope buffers<cr>")
    k.nnoremap("<Leader>d", ":Lex<cr>")
    k.nnoremap("<Leader>f", ":Telescope find_files<cr>")

    -- Leader Leader keys
    k.nnoremap("<Leader><Leader>f", ":Telescope live_grep<cr>")

    k.nnoremap("<Leader>q", ":Telescope help_tags<cr>")
    k.nnoremap("<Leader>u", ":UndotreeToggle<cr>")

    -- Moving through quickfix
    k.nnoremap("<Leader>j", ":cnext<cr>")
    k.nnoremap("<Leader>k", ":cprev<cr>")

    -- Git TODO: make this work better
    k.nnoremap("<Leader>gg", ":Git ")
    k.nnoremap("<Leader>gf", ":Telescope git_files<cr>")
    -- Commits
    k.nnoremap("<Leader>ga", ":Git commit<cr>") -- commit what is staged
    k.nnoremap("<Leader>gs", ":Git<cr>") -- git status & stager
    k.nnoremap("<Leader>gc", ":Git commit %") -- commit working file
    -- Staging
    k.nnoremap("<Leader>gd", ":Git diff %<cr>")
    k.nnoremap("<Leader>gD", ":Git diff<cr>")
    k.nnoremap("<Leader>g;", ":Git diff ORIG_HEAD HEAD<cr>")
    -- Remote
    k.nnoremap("<Leader>gl", ":Git log<cr>")
    k.nnoremap("<Leader>gp", ":Git pull<cr>")

    -- Toggle options
    k.nnoremap("<Leader>;", ":noh<cr>")
    k.nnoremap("<Leader>tw", ":set wrap!<cr>")
    k.nnoremap("<Leader>tp", ":set paste!<cr>")
    k.nnoremap("<Leader>ts", ":set spell!<cr>")

    -- Move blocks of text around
    k.vnoremap("<C-j>", ":m '>+1<cr>gv=gv")
    k.vnoremap("<C-k>", ":m '<-2<cr>gv=gv")
end

return M
