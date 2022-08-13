local lspconfig = require("lspconfig")
local installer = require("nvim-lsp-installer")
require("lsp_signature").setup {}

local square_border = {
    { "┌", "FloatBorder" },
    { "─", "FloatBorder" },
    { "┐", "FloatBorder" },
    { "│", "FloatBorder" },
    { "┘", "FloatBorder" },
    { "─", "FloatBorder" },
    { "└", "FloatBorder" },
    { "│", "FloatBorder" }
}

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
    lsp_nmap("<leader>r", vim.lsp.buf.rename)
    lsp_nmap("<leader>l", vim.diagnostic.setloclist)
    -- lsp_nmap("<Leader>j", vim.diagnostic.goto_next)
    -- lsp_nmap("<Leader>k", vim.diagnostic.goto_prev)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
    vim.api.nvim_create_user_command("CodeAction", vim.lsp.buf.code_action, {})
end

local function on_attach(client, bufnr) -- TODO: use client
    lsp_keymaps(bufnr)

    vim.api.nvim_create_augroup("LSPFormatOnWrite", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePre", {
        group = "LSPFormatOnWrite",
        desc = "autoformat with lsp",
        callback = function()
            vim.lsp.buf.formatting_sync(nil, 2000)
        end
    })
end

-- ## SETUP
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
        border        = square_border,
        source        = "always",
        header        = "",
        prefix        = "",
        focusable     = false,
        severity_sort = true
    },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = square_border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = square_border,
})

-- configure lsps
installer.setup()

for _, s in ipairs(installer.get_installed_servers()) do
    local setup_tbl = { on_attach = on_attach }

    -- check if there is a settings file
    local found, settings = pcall(require, "user.lsp-settings." .. s.name)
    -- if it is, then append its contents to the table
    if found and settings ~= true then
        setup_tbl = vim.tbl_deep_extend("force", settings, setup_tbl)
    end

    lspconfig[s.name].setup(setup_tbl)
end

-- configure capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
