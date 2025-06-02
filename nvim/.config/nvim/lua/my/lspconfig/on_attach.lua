local border = require("my.aesthetic.square-border")

local disable_autoformat = {
    "clangd", "powershell_es", "jtdls"
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('MyLspOnAttach', { clear = true }),
    callback = function(event)
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
                        for _, x in ipairs(disable_autoformat) do
                            if x == c.name then
                                return false
                            end
                        end

                        return true
                    end
                }
            end
        })
    end
})
