local M = {}

function M.setup()
    local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
    vim.lsp.config("*", { capabilities = lsp_capabilities })
    require("my.lspconfig.on_attach")
end

return M
