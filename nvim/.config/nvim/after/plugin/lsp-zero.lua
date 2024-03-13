local my = require("my.lsp-config")

local okay, cmp = pcall(require, 'cmp')
if not okay then return end

local okay, zero = pcall(require, 'lsp-zero')
if not okay then return end

zero.preset {
    manage_nvim_cmp = {
        set_sources = 'recommended',
        set_extra_mappings = true
    }
}

-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = zero.defaults.cmp_mappings({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
})

zero.setup_nvim_cmp({
    mapping = cmp_mappings
})

zero.ensure_installed(my.default_lsps())

zero.on_attach(function(client, bufnr)
    _ = client

    vim.lsp.set_log_level("error")
    my.lsp_keybinds(bufnr)

    require("lsp_signature").on_attach({
        bind = true,
        handler_opts = my.border,
    }, bufnr)

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, my.border)

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, my.border)

    local augroup = vim.api.nvim_create_augroup("MyLspConfig", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        desc = "autoformat with lsp",
        callback = my.autofmt_disable { "clangd", "powershell_es" }
    })
end)

local okay, lspconfig = pcall(require, "lspconfig")
if okay then
    lspconfig.lua_ls.setup(zero.nvim_lua_ls())
    lspconfig.hls.setup(my.haskell_setup)
end

zero.setup()
