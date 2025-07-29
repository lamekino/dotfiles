local mason = require("mason")
local masonlsp = require("mason-lspconfig")

local function has(...) return vim.fn.has(...) ~= 0 end
local function exe(...) return vim.fn.executable(...) ~= 0 end

local install_by_default = {
    ["lua_ls"] = true,
    ["clangd"] = exe("unzip"),
    ["pylsp"] = exe("python3"), -- FIXME: requires venv
    ["hls"] = exe("ghcup"),
    ["jdtls"] = exe("java") and not has("macunix"),
    ["powershell_es"] = has("wsl") or has("win32")
}

local ensure_installed = {}
for server, is_enabled in pairs(install_by_default) do
    if is_enabled then
        table.insert(ensure_installed, server)
    end
end

mason.setup({})
masonlsp.setup({ ensure_installed = ensure_installed })
