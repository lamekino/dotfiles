local mason = require("mason")
local masonlsp = require("mason-lspconfig")

local install_by_default = {
    ["lua_ls"] = true,
    ["clangd"] = vim.fn.executable("unzip") ~= 0,  -- clangd installer dependency
    ["pylsp"] = vim.fn.executable("python3") ~= 0, -- FIXME: requires venv
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
