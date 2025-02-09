local M = {}

local defaults_enabled = {
    ["lua_ls"] = 1,
    ["clangd"] = 1,
    ["pylsp"] = 1,
    ["jdtls"] = vim.fn.executable("java"),
    ["hls"] = vim.fn.executable("ghcup"),
    ["powershell_es"] = vim.fn.has("wsl") or vim.fn.has("win32")
}

-- FIXME:
for lsname, enabled in ipairs(defaults_enabled) do
    if enabled then
        table.insert(M, lsname)
    end
end

return M
