local border = require("my.aesthetic.square-border")

local autoformat = {
    disabled = { "clangd", "powershell_es", "jtdls" },
}

function autoformat:filter_callback()
    return function(client)
        for _, lspname in ipairs(self.disabled) do
            if lspname == client.name then
                return false
            end
        end

        return true
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('MyLspOnAttach', { clear = true }),
    callback = function(_)
        vim.api.nvim_create_user_command(
            "CodeAction",
            vim.lsp.buf.code_action,
            {}
        )

        vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "autoformat with lsp",
            group = vim.api.nvim_create_augroup("MyLspAutoFmt", {}),
            callback = function()
                vim.lsp.buf.format { filter = autoformat:filter_callback() }
            end
        })
    end
})
