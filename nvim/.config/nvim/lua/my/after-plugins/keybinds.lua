local has_telescope, ts = pcall(require, "telescope.builtin")

local function tsbuiltin(name)
    local function fail(...)
        _ = ...
        error("keybind disabled: no telescope", 0)
    end

    if has_telescope then
        return ts[name]
    end

    return fail
end

local function create_mapper(mode, opts)
    return function(keys, func)
        vim.keymap.set(mode, keys, func, opts)
    end
end

local Z = {
    ["map"]      = create_mapper("", { silent = true }),
    ["nnoremap"] = create_mapper("n", { noremap = true }),
    ["vnoremap"] = create_mapper("v", { noremap = true }),
    ["nlspmap"]  = create_mapper("n", { buffer = 0, noremap = true })
}

-- disable defaults
Z.map('<Space>', '<Nop>')
Z.map("<ScrollWheelLeft>", "<Nop>")
Z.map("<ScrollWheelRight>", "<Nop>")

-- copy to system clipboard
Z.vnoremap("<C-y>", "\"+y")

-- search multiple files
Z.nnoremap("?", ":lvimgrep '' **" .. string.rep("<Left>", 4))

-- move to end of line on line concat
Z.nnoremap("J", "J$")

-- move blocks of text around
Z.vnoremap("<C-j>", ":m '>+1<cr>gv=gv")
Z.vnoremap("<C-k>", ":m '<-2<cr>gv=gv")

-- recenter view on pgup/pgdn
Z.nnoremap("<C-d>", "<C-d>zz")
Z.nnoremap("<C-u>", "<C-u>zz")

-- buffer navigation
Z.map("s", "<Nop>")
Z.nnoremap("sn", ":bn<cr>")
Z.nnoremap("sp", ":bp<cr>")
Z.nnoremap("sd", ":bd<cr>")
Z.nnoremap("ss", ":enew<cr>")
Z.nnoremap("sv", ":vsp<cr>")
Z.nnoremap("sh", ":sp<cr>")

-- disable search highlight
Z.nnoremap("<Leader>;", ":noh<cr>")

-- search from beginning of line
Z.nnoremap("<Leader>`", "/^\\(\\s*\\)")

-- directory navigation
Z.nnoremap("<Leader>1", [[
<cmd>GitRootCd
<cmd>pwd
]])
Z.nnoremap("<Leader>2", [[
<cmd>cd %:p:h
<cmd>pwd
]])
Z.nnoremap("<Leader>3", [[
<cmd>cd ..
<cmd>pwd
]])
Z.nnoremap("<Leader>4", [[
<cmd>cd -
<cmd>pwd
]])
Z.nnoremap("<Leader>0", string.format([[
<cmd>cd %s
<cmd>pwd
]], vim.fn.stdpath("config")))

-- plugins
Z.nnoremap("<Leader>a", ":make<cr>")
Z.nnoremap("<Leader>s", tsbuiltin("buffers"))
Z.nnoremap("<Leader>d", ":Lex <C-r>=expand('%:p:h')<cr><cr>")
Z.nnoremap("<Leader>f", tsbuiltin("find_files"))
Z.nnoremap("<Leader>g", ":Neogit<cr>")

Z.nnoremap("<Leader>q", tsbuiltin("help_tags"))
Z.nnoremap("<Leader>w", function()
    tsbuiltin("man_pages")({ sections = { "ALL" } })
end)

Z.nnoremap("<Leader>u", ":UndotreeToggle<cr>")

-- close menu
Z.nnoremap("<Leader><Leader>", ":cclose | lclose<cr>")

-- location list
Z.nnoremap("<Leader>v", ":lwindow<cr>")
Z.nnoremap("<C-j>", ":lnext<cr>")
Z.nnoremap("<C-k>", ":lprev<cr>")

-- quickfix list
Z.nnoremap("<Leader>c", ":cwindow<cr>")
Z.nnoremap("<Leader>j", ":cnext<cr>")
Z.nnoremap("<Leader>k", ":cprev<cr>")

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        -- jump to
        Z.nlspmap("gd", vim.lsp.buf.definition)
        Z.nlspmap("gt", vim.lsp.buf.type_definition)
        Z.nlspmap("gi", vim.lsp.buf.implementation)
        Z.nlspmap("gr", vim.lsp.buf.references)

        -- info
        Z.nlspmap("K", vim.lsp.buf.hover)
        Z.nlspmap("<C-k>", vim.lsp.buf.signature_help)

        -- edit
        Z.nlspmap("<Leader>h", vim.lsp.buf.code_action)
        Z.nlspmap("<Leader>r", vim.lsp.buf.rename)

        -- diagnostic
        Z.nlspmap("<Leader>l", vim.diagnostic.setloclist)
        Z.nlspmap("<C-n>", vim.diagnostic.goto_next)
        Z.nlspmap("<C-p>", vim.diagnostic.goto_prev)
    end
})
