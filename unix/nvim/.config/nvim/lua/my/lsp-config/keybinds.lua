local M = {}

local lsp_keymapper = function(mode, buffer)
    return function(keys, callback)
        local opts = { buffer = buffer, noremap = true }
        vim.keymap.set(mode, keys, callback, opts)
    end
end

M.set = function(buffer)
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

return M
