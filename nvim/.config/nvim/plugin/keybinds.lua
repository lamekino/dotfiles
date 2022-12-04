local create_mapper = function(mode, opts)
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

-- Set leader key map('<Space>', '<Nop>')
vim.g.mapleader = " "

-- registers
nnoremap("_", "\"_d")
nnoremap("Y", "\"+y")
vnoremap("<C-y>", "\"+y")
nnoremap("<C-p>", "\"+p")

-- Function Keys
imap("<F1>", "") -- disable the F1 for help

-- Control keys
nnoremap("<C-i>", ":ls<cr>")

-- Leader keys
nnoremap("<Leader>a", ":Neogit<cr>")
nnoremap("<Leader>s", ":Telescope buffers<cr>")
nnoremap("<Leader>d", ":Lex<cr>")
nnoremap("<Leader>f", ":Telescope find_files<cr>")
nnoremap("<Leader>g", ":Telescope live_grep<cr>")

nnoremap("<Leader>q", ":Telescope help_tags<cr>")
nnoremap("<Leader>w", function()
    require("telescope.builtin").man_pages {
        sections = { "ALL" }
    }
end)
nnoremap("<Leader>u", ":UndotreeToggle<cr>")

map("s", "<Nop>")
nnoremap("sn", ":bn<cr>")
nnoremap("sp", ":bp<cr>")
nnoremap("sd", ":bd<cr>")
nnoremap("ss", ":enew<cr>")
nnoremap("sv", ":vsp<cr>")
nnoremap("sh", ":sp<cr>")

nnoremap("<Leader><Leader>d", ":Neogit diff %<cr>")
-- Remote
nnoremap("<Leader><Leader>l", ":Neogit log<cr>")
nnoremap("<Leader>]", ":Neogit push<cr>")
nnoremap("<Leader>[", ":Neogit pull<cr>")

-- location list (alt key)
nnoremap("<Esc>a", ":lwindow<cr>")
nnoremap("<Esc>q", ":lclose<cr>")
nnoremap("<Esc>j", ":lnext<cr>")
nnoremap("<Esc>k", ":lprev<cr>")
nnoremap("<Esc>;", ":lvimgrep FIXME ** | lwindow<cr>")

-- quickfix list (requires csi escapes to be enabled)
-- http://www.leonerd.org.uk/hacks/fixterms/
nnoremap("<C-S-a>", ":cwindow<cr>")
nnoremap("<C-S-q>", ":cclose<cr>")
nnoremap("<C-S-j>", ":cnext<cr>")
nnoremap("<C-S-k>", ":cprev<cr>")
nnoremap("<C-;>", ":make | cwindow<cr>")

-- ToggleTerm
nnoremap("<S-Return>", ":ToggleTerm direction=float<cr>")
tnoremap("<S-Return>", "<C-\\><C-n>:ToggleTerm<cr>")
tnoremap("<C-w>", "<C-\\><C-n><C-w>")
tnoremap("<C-n>", "<C-\\><C-n>")

-- Toggle options
nnoremap("<Leader>;", ":noh<cr>")
nnoremap("<Leader><Leader>w", ":set wrap!<cr>")
nnoremap("<Leader><Leader>p", ":set paste!<cr>")
nnoremap("<Leader><Leader>s", ":set spell!<cr>")

-- Move blocks of text around
vnoremap("<C-j>", ":m '>+1<cr>gv=gv")
vnoremap("<C-k>", ":m '<-2<cr>gv=gv")
