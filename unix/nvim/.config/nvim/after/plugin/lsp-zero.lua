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

zero.setup_nvim_cmp({
    mapping = zero.defaults.cmp_mappings({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    })
})

zero.ensure_installed(my.default_servers)

zero.on_attach(function(client, bufnr)
    local handlers = vim.lsp.handlers

    _ = client

    my.keybinds.set(bufnr)

    require("lsp_signature").on_attach({
        bind = true,
        handler_opts = my.border,
    }, bufnr)

    handlers["textDocument/hover"] =
        vim.lsp.with(handlers.hover, my.border)

    handlers["textDocument/signatureHelp"] =
        vim.lsp.with(handlers.signature_help, my.border)

    -- TODO: add the ability to enable these via a command
    my.autofmt:disable("clangd")
    my.autofmt:disable("powershell_es")
    my.autofmt:disable("jdtls")

    vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "autoformat with lsp",
        group = vim.api.nvim_create_augroup("MyLspAutoFmt", {}),
        callback = my.autofmt:callback()
    })
end)

local okay, lspconfig = pcall(require, "lspconfig")
if okay then
    lspconfig.lua_ls.setup(zero.nvim_lua_ls())
    lspconfig.hls.setup(my.config.haskell)
end

zero.setup()
