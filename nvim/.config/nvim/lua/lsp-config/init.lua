local okay, _ = pcall(require, "lspconfig")
if not okay then
    return
end

require("lsp-config.nvim-lsp-installer")
require("lsp-config.config").setup()
require("lsp-config.nvim-cmp")
require("lsp-config.luasnips")
