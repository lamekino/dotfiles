local M = {}

function M.setup()
    require("my.lspconfig.diagnostics")
    require("my.lspconfig.mason")
    require("my.lspconfig.on_attach")
end

return M
