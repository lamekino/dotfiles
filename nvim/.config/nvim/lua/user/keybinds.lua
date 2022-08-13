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
    k.nnoremap("sS", ":sp<CR>")
    k.nnoremap("sd", ":bd<CR>")
    k.nnoremap("sp", ":bprev!<cr>")
    k.nnoremap("sn", ":bnext!<cr>")

    -- registers
    k.nnoremap("_", "\"_d")
    k.nnoremap("Y", "\"+y")
    k.vnoremap("<C-y>", "\"+y")
    k.nnoremap("<C-p>", "\"+p")

    -- Function Keys
    k.imap("<F1>", "") -- disable the F1 for help

    -- Leader keys
    k.nnoremap("<Leader>a", ":Neogit<cr>")
    k.nnoremap("<Leader>s", ":Telescope buffers<cr>")
    k.nnoremap("<Leader>d", ":Lex<cr>")
    k.nnoremap("<Leader>f", ":Telescope find_files<cr>")
    k.nnoremap("<Leader>g", ":lvimgrep ")

    k.nnoremap("<Leader>q", ":Telescope help_tags<cr>")
    k.nnoremap("<Leader>w", ":Telescope man_pages<cr>")
    k.nnoremap("<Leader>e", ":Telescope live_grep<cr>")
    k.nnoremap("<Leader>u", ":UndotreeToggle<cr>")


    -- location list (alt key)
    k.nnoremap("<Esc>a", ":lwindow<cr>")
    k.nnoremap("<Esc>q", ":lclose<cr>")
    k.nnoremap("<Esc>j", ":lnext<cr>")
    k.nnoremap("<Esc>k", ":lprev<cr>")

    -- quickfix list (requires csi escapes to be enabled)
    -- http://www.leonerd.org.uk/hacks/fixterms/
    k.nnoremap("<C-S-a>", ":cwindow<cr>")
    k.nnoremap("<C-S-q>", ":cclose<cr>")
    k.nnoremap("<C-S-j>", ":cnext<cr>")
    k.nnoremap("<C-S-k>", ":cprev<cr>")

    -- Building
    k.nnoremap("<C-;>", ":make<cr>")

    -- ToggleTerm
    k.nnoremap("<S-Return>", ":ToggleTerm direction=float<cr>")
    k.tnoremap("<S-Return>", "<C-\\><C-n>:ToggleTerm<cr>")
    k.tnoremap("<C-w>", "<C-\\><C-n><C-w>")
    k.tnoremap("<C-n>", "<C-\\><C-n>")

    -- NeoGit
    -- Staging
    k.nnoremap("<Leader><Leader>d", ":Neogit diff %<cr>")
    -- Remote
    k.nnoremap("<Leader><Leader>l", ":Neogit log<cr>")
    k.nnoremap("<Leader>]", ":Neogit push<cr>")
    k.nnoremap("<Leader>[", ":Neogit pull<cr>")

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
