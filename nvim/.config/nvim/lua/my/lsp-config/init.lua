local M = {}
local border = require("my.aesthetics.square_border")

-- aesthetics
M.border = {
    border = border
}

-- lsp keybinds
local lsp_keymapper = function(mode, buffer)
    return function(keys, callback)
        local opts = { buffer = buffer, noremap = true }
        vim.keymap.set(mode, keys, callback, opts)
    end
end

M.lsp_keybinds = function(buffer)
    local nmap = lsp_keymapper("n", buffer)

    nmap("gd", vim.lsp.buf.definition)
    nmap("gt", vim.lsp.buf.type_definition)
    nmap("gi", vim.lsp.buf.implementation)
    nmap("gr", vim.lsp.buf.references)
    nmap("K", vim.lsp.buf.hover)
    nmap("<C-k>", vim.lsp.buf.signature_help)
    nmap("<leader>r", vim.lsp.buf.rename)
    nmap("<leader>l", vim.diagnostic.setloclist)
    nmap("<Leader>j", vim.diagnostic.goto_next)
    nmap("<Leader>k", vim.diagnostic.goto_prev)
end

-- disable autoformat
M.autofmt_disable = function(disabled_autofmt)
    local disabled_lsp = {}
    for _, name in ipairs(disabled_autofmt) do
        disabled_lsp[name] = true
    end

    return function ()
        vim.lsp.buf.format {
            filter = function(c)
                return disabled_lsp[c.name] ~= nil
            end
        }
    end
end

-- install default lsps
M.default_lsps = function ()
    local always = { "lua_ls", "clangd", "jdtls", "pylsp" }

    -- install powershell lsp on windows host
    if vim.fn.has("wsl") or vim.fn.has("win32") then
        table.insert(always, "powershell_es")
    end

    -- install haskell lsp if ghcup is available
    if vim.fn.executable("ghcup") then
        table.insert(always, "hls")
    end
end

-- lspconfig settings
M.haskell_setup = {
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
}

return M
