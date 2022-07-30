local M = {}

M.square_border = {
    { "┌", "FloatBorder" },
    { "─", "FloatBorder" },
    { "┐", "FloatBorder" },
    { "│", "FloatBorder" },
    { "┘", "FloatBorder" },
    { "─", "FloatBorder" },
    { "└", "FloatBorder" },
    { "│", "FloatBorder" }
}

M.setup = function()
    -- create the autocmd for opening diagnostic windows
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        callback = function()
            vim.diagnostic.open_float(nil, { focus = false })
        end
    })

    vim.diagnostic.config {
        virtual_text     = false,
        signs            = true,
        underline        = false,
        update_in_insert = false,
        severity_sort    = true,

        float = {
            style         = "rounded",
            border        = M.square_border,
            source        = "always",
            header        = "",
            prefix        = "",
            focusable     = false,
            severity_sort = true
        },
    }

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = M.square_border,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = M.square_border,
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

    vim.api.nvim_create_augroup("LSPFormatOnWrite", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePre", {
        group = "LSPFormatOnWrite",
        desc = "autoformat with lsp",
        callback = function()
            if vim.v.version >= 800 then
                -- new format for nvim 8.0
                vim.lsp.buf.format {
                    async = false,
                    timeout_ms = 2000,
                }
                return
            end

            vim.lsp.buf.formatting_sync(nil, 2000)

        end
    })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
return M
