local M = {}
local border = require("my.aesthetic.square-border")

M.border = { border = border }
M.autofmt = require("my.lsp-config.autofmt")
M.default_servers = require("my.lsp-config.default-servers")

-- lsp setup
M.config = {}
M.config.haskell = {
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
}

return M
