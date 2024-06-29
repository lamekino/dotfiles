local M = {}

M = {
    "lua_ls",
    "clangd",
    -- "jdtls",
    "pylsp"
}

-- install powershell lsp on windows host
if vim.fn.has("wsl") or vim.fn.has("win32") then
    table.insert(M, "powershell_es")
end

-- install haskell lsp if ghcup is available
if vim.fn.executable("ghcup") then
    table.insert(M, "hls")
end

return M
