local mason = require("mason")
local masonlsp = require("mason-lspconfig")

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
vim.lsp.config("*", { capabilities = lsp_capabilities })

local install_by_default = {
    ["lua_ls"] = true,
    ["clangd"] = true,
    ["pylsp"] = true, -- requires venv
    ["jdtls"] = vim.fn.executable("java") ~= 0,
    ["hls"] = vim.fn.executable("ghcup") ~= 0,
    ["powershell_es"] = vim.fn.has("wsl") + vim.fn.has("win32") ~= 0
}

local ensure_installed = {}
for server, is_enabled in pairs(install_by_default) do
    if is_enabled then
        table.insert(ensure_installed, server)
    end
end

mason.setup({})
masonlsp.setup({ ensure_installed = ensure_installed })
