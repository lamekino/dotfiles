-- TODO: this needs refactored bad
local has_telescope, ts = pcall(require, "telescope.builtin")
local has_luasnip, ls = pcall(require, "luasnip")

-- set keymaps
local function create_mapper(mode, opts)
    return function(keys, func)
        vim.keymap.set(mode, keys, func, opts)
    end
end

local global = {
    ["map"] = create_mapper("", { silent = true }),
    ["imap"] = create_mapper("i", { silent = true }),
    ["nnoremap"] = create_mapper("n", { noremap = true }),
    ["vnoremap"] = create_mapper("v", { noremap = true }),
}

local function tswrap(name, opts)
    if opts == nil then
        return ts[name]
    end

    return function()
        return ts[name](opts)
    end
end

local tsbuiltin = has_telescope and tswrap or (function(...)
    _ = ...
    error("keybind disabled: no telescope", 0)
end)


-- plugins
global.nnoremap("<Leader>a", ":make<cr>")
global.nnoremap("<Leader>s", tsbuiltin("buffers"))
global.nnoremap("<Leader>d", ":Lex <C-r>=expand('%:p:h')<cr><cr>")
global.nnoremap("<Leader>f", tsbuiltin("find_files"))
global.nnoremap("<Leader>g", ":Neogit<cr>")

global.nnoremap("<Leader>q", tsbuiltin("help_tags"))
global.nnoremap("<Leader>w", tsbuiltin("man_pages", { sections = { "ALL" } }))
global.nnoremap("<Leader>u", ":UndotreeToggle<cr>")

-- luasnip
if has_luasnip then
    local snip_move = create_mapper({ "i", "s" }, { silent = true })

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
    group = vim.api.nvim_create_augroup("MyLspKeybinds", { clear = true }),
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

        -- server
        nnoremap("<Leader>'", ":LspRestart<CR>")
    end
})
