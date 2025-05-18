local has_telescope, ts = pcall(require, "telescope.builtin")
local has_luasnip, ls = pcall(require, "luasnip")

local function tsbuiltin(name)
    local function fail(...)
        _ = ...
        error("keybind disabled: no telescope", 0)
    end

    return has_telescope and ts[name] or fail
end

local function create_mapper(mode, opts)
    return function(keys, func)
        vim.keymap.set(mode, keys, func, opts)
    end
end

local global = {
    ["map"]      = create_mapper("", { silent = true }),
    ["imap"]     = create_mapper("i", { silent = true }),
    ["nnoremap"] = create_mapper("n", { noremap = true }),
    ["vnoremap"] = create_mapper("v", { noremap = true }),
}

-- disable defaults
global.map('<Space>', '<Nop>')
global.map("<ScrollWheelLeft>", "<Nop>")
global.map("<ScrollWheelRight>", "<Nop>")

-- copy to system clipboard
global.vnoremap("<C-y>", "\"+y")

-- search multiple files
global.nnoremap("?", ":lvimgrep '' **" .. string.rep("<Left>", 4))

-- move to end of line on line concat
global.nnoremap("J", "J$")

-- move blocks of text around
global.vnoremap("<C-j>", ":m '>+1<cr>gv=gv")
global.vnoremap("<C-k>", ":m '<-2<cr>gv=gv")

-- recenter view on pgup/pgdn
global.nnoremap("<C-d>", "<C-d>zz")
global.nnoremap("<C-u>", "<C-u>zz")

-- buffer navigation
global.map("s", "<Nop>")
global.nnoremap("sn", ":bn<cr>")
global.nnoremap("sp", ":bp<cr>")
global.nnoremap("sd", ":bd<cr>")
global.nnoremap("ss", ":enew<cr>")
global.nnoremap("sv", ":vsp<cr>")
global.nnoremap("sh", ":sp<cr>")

-- disable search highlight
global.nnoremap("<Leader>;", ":noh<cr>")

-- search from beginning of line
global.nnoremap("<Leader>`", "/^\\(\\s*\\)")

-- directory navigation
global.nnoremap("<Leader>1", [[
<cmd>GitRootCd
<cmd>pwd
]])

global.nnoremap("<Leader>2", [[
<cmd>cd %:p:h
<cmd>pwd
]])

global.nnoremap("<Leader>3", [[
<cmd>cd ..
<cmd>pwd
]])

global.nnoremap("<Leader>4", [[
<cmd>cd -
<cmd>pwd
]])

global.nnoremap("<Leader>0", string.format([[
<cmd>cd %s
<cmd>pwd
]], vim.fn.stdpath("config")))

-- plugins
global.nnoremap("<Leader>a", ":make<cr>")
global.nnoremap("<Leader>s", tsbuiltin("buffers"))
global.nnoremap("<Leader>d", ":Lex <C-r>=expand('%:p:h')<cr><cr>")
global.nnoremap("<Leader>f", tsbuiltin("find_files"))
global.nnoremap("<Leader>g", ":Neogit<cr>")

global.nnoremap("<Leader>q", tsbuiltin("help_tags"))
global.nnoremap("<Leader>w", function()
    tsbuiltin("man_pages")({ sections = { "global" } })
end)

global.nnoremap("<Leader>u", ":UndotreeToggle<cr>")

-- close menu
global.nnoremap("<Leader><Leader>", ":cclose | lclose<cr>")

-- location list
global.nnoremap("<Leader>v", ":lwindow<cr>")
global.nnoremap("<C-j>", ":lnext<cr>")
global.nnoremap("<C-k>", ":lprev<cr>")

-- quickfix list
global.nnoremap("<Leader>c", ":cwindow<cr>")
global.nnoremap("<Leader>j", ":cnext<cr>")
global.nnoremap("<Leader>k", ":cprev<cr>")

-- luasnip
if has_luasnip then
    local snip_expand = create_mapper("i", {silent = true})
    local snip_move = create_mapper({"i", "s"}, {silent = true})

    global.imap("<C-k>", function() ls.expand() end)

    snip_move("<C-f>", function() ls.jump(1) end)
    snip_move("<C-b>", function() ls.jump(-1) end)
    snip_move("<C-e>",
        function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end
    )
end

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('MyLspKeybinds', { clear = true }),
    callback = function(event)
        local nnoremap = create_mapper("n", {
            buffer = event.buf,
            noremap = true
        })

        -- jump to
        nnoremap("gd", vim.lsp.buf.definition)
        nnoremap("gt", vim.lsp.buf.type_definition)
        nnoremap("gi", vim.lsp.buf.implementation)
        nnoremap("gr", vim.lsp.buf.references)

        -- info
        nnoremap("K", vim.lsp.buf.hover)
        nnoremap("<C-k>", vim.lsp.buf.signature_help)

        -- edit
        nnoremap("<Leader>h", vim.lsp.buf.code_action)
        nnoremap("<Leader>r", vim.lsp.buf.rename)

        -- diagnostic
        nnoremap("<Leader>l", vim.diagnostic.setloclist)
        nnoremap("<C-n>", vim.diagnostic.goto_next)
        nnoremap("<C-p>", vim.diagnostic.goto_prev)
    end
})
