local function create_mapper(mode, opts)
    return function(keys, func)
        vim.keymap.set(mode, keys, func, opts)
    end
end

local map      = create_mapper("", { silent = true })
local imap     = create_mapper("i", { silent = true })
local nmap     = create_mapper("n", { silent = true })
local nnoremap = create_mapper("n", { noremap = true })
local inoremap = create_mapper("i", { noremap = true })
local vnoremap = create_mapper("v", { noremap = true })
local tnoremap = create_mapper("t", { noremap = true })

-- Set leader key
map('<Space>', '<Nop>')
vim.g.mapleader = " "

-- Splits
map("s", "<nop>")
nnoremap("ss", ":vsp<CR>")
nnoremap("sS", ":sp<CR>")
nnoremap("sd", ":bd<CR>")
nnoremap("sp", ":bprev!<cr>")
nnoremap("sn", ":bnext!<cr>")

-- registers
nnoremap("_", "\"_d")
nnoremap("Y", "\"+y")
vnoremap("<C-y>", "\"+y")
nnoremap("<C-p>", "\"+p")

-- Function Keys
imap("<F1>", "") -- disable the F1 for help

-- Leader keys
nnoremap("<Leader>a", ":Neogit<cr>")
nnoremap("<Leader>s", ":Telescope buffers<cr>")
nnoremap("<Leader>d", ":Lex<cr>")
nnoremap("<Leader>f", ":Telescope find_files<cr>")
nnoremap("<Leader>g", ":lvimgrep ")

nnoremap("<Leader>q", ":Telescope help_tags<cr>")
nnoremap("<Leader>w", ":Telescope man_pages<cr>")
nnoremap("<Leader>e", ":Telescope live_grep<cr>")
nnoremap("<Leader>u", ":UndotreeToggle<cr>")


-- location list (alt key)
nnoremap("<Esc>a", ":lwindow<cr>")
nnoremap("<Esc>q", ":lclose<cr>")
nnoremap("<Esc>j", ":lnext<cr>")
nnoremap("<Esc>k", ":lprev<cr>")

-- quickfix list (requires csi escapes to be enabled)
-- http://www.leonerd.org.uk/hacks/fixterms/
nnoremap("<C-S-a>", ":cwindow<cr>")
nnoremap("<C-S-q>", ":cclose<cr>")
nnoremap("<C-S-j>", ":cnext<cr>")
nnoremap("<C-S-k>", ":cprev<cr>")

-- Building
nnoremap("<C-;>", ":make<cr>")

-- ToggleTerm
nnoremap("<S-Return>", ":ToggleTerm direction=float<cr>")
tnoremap("<S-Return>", "<C-\\><C-n>:ToggleTerm<cr>")
tnoremap("<C-w>", "<C-\\><C-n><C-w>")
tnoremap("<C-n>", "<C-\\><C-n>")

-- NeoGit
-- Staging
nnoremap("<Leader><Leader>d", ":Neogit diff %<cr>")
-- Remote
nnoremap("<Leader><Leader>l", ":Neogit log<cr>")
nnoremap("<Leader>]", ":Neogit push<cr>")
nnoremap("<Leader>[", ":Neogit pull<cr>")

-- Toggle options
nnoremap("<Leader>;", ":noh<cr>")
nnoremap("<Leader>tw", ":set wrap!<cr>")
nnoremap("<Leader>tp", ":set paste!<cr>")
nnoremap("<Leader>ts", ":set spell!<cr>")

-- Move blocks of text around
vnoremap("<C-j>", ":m '>+1<cr>gv=gv")
vnoremap("<C-k>", ":m '<-2<cr>gv=gv")
