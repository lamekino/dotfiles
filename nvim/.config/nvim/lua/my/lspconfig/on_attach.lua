local border = require("my.aesthetic.square-border")

local disable_autoformat = {
    "clangd", "powershell_es", "jtdls"
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('MyLspOnAttach', { clear = true }),
    callback = function(event)
        local handlers = vim.lsp.handlers

        -- set the borders for windows
        handlers["textDocument/hover"] =
            vim.lsp.with(handlers.hover, border)

        handlers["textDocument/signatureHelp"] =
            vim.lsp.with(handlers.signature_help, border)

        -- create a command for codeactions
        vim.api.nvim_create_user_command("CodeAction",
            vim.lsp.buf.code_action, {})

        -- autoformat files before writing them
        vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "autoformat with lsp",
            group = vim.api.nvim_create_augroup("MyLspAutoFmt", {}),
            callback = function()
                vim.lsp.buf.format {
                    filter = function(c)
                        return disable_autoformat[c.name] == nil
                    end
                }
            end
        })
    end
})
