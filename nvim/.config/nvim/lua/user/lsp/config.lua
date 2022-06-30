local M = {}
local old_keymap = vim.api.nvim_buf_set_keymap

M.setup = function()
    -- create the autocmd for opening diagnostic windows
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        callback = function()
            vim.diagnostic.open_float(nil, { focus = false })
        end
    })

    local config = {
        virtual_text = false, -- annoying
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
        float = {
            style     = "minimal",
            border    = "rounded",
            source    = "always",
            header    = "",
            prefix    = "",
            focusable = false
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local function lsp_keymaps(bufnr)
    local lsp_nmap = function(keys, callback)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", keys, callback, opts)
    end

    lsp_nmap("gd", vim.lsp.buf.definition)
    lsp_nmap("gt", vim.lsp.buf.type_definition)
    lsp_nmap("gi", vim.lsp.buf.implementation)
    lsp_nmap("gr", vim.lsp.buf.references)
    lsp_nmap("K", vim.lsp.buf.hover)
    lsp_nmap("<C-k>", vim.lsp.buf.signature_help)
    lsp_nmap("<leader>rr", vim.lsp.buf.rename)
    lsp_nmap("<leader>dj", vim.diagnostic.goto_next)
    lsp_nmap("<leader>dk", vim.diagnostic.goto_prev)
    lsp_nmap("<leader>l", vim.diagnostic.setloclist)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
    vim.api.nvim_create_user_command("CodeAction", vim.lsp.buf.code_action, {})
end

M.on_attach = function(client, bufnr) -- TODO: use client
    lsp_keymaps(bufnr)

    local lsp_group = vim.api.nvim_create_augroup("LSP", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "autoformat",
        group = lsp_group,
        callback = function() vim.lsp.buf.formatting_sync(nil, 2000) end
    })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
return M
