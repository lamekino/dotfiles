local lspconfig = require("lspconfig")
local mason = require("mason")
local masonlsp = require("mason-lspconfig")
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

local function lsp_keymaps(opts)
    local lsp_nmap = function(keys, callback)
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
    lsp_nmap("<Leader>j", vim.diagnostic.goto_next)
    lsp_nmap("<Leader>k", vim.diagnostic.goto_prev)
end

vim.api.nvim_create_augroup("MyLspConfig", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = "MyLspConfig",
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        lsp_keymaps {
            buffer = ev.buf,
            noremap = true
        }

        vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})
        vim.api.nvim_create_user_command("CodeAction", vim.lsp.buf.code_action, {})
    end
})

-- create the autocmd for opening diagnostic windows
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function()
        if vim.fn.mode() ~= "i" then
            vim.diagnostic.open_float(nil, { focus = false })
        end
    end
})

vim.api.nvim_create_augroup("LSPFormatOnWrite", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "LSPFormatOnWrite",
    desc = "autoformat with lsp",
    callback = function()
        local disabled_formatters = {
            ["clangd"] = true
        }

        vim.lsp.buf.format {
            filter = function(c)
                return disabled_formatters[c.name] == nil
            end
        }
    end
})

vim.diagnostic.config {
    virtual_text     = false,
    signs            = true,
    underline        = false,
    update_in_insert = false,
    severity_sort    = true,

    float            = {
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

-- configure capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- https://github.com/neovim/neovim/pull/13183#issue-731760011
capabilities["textDocument/completion/completionItem/snippetSupport"] = true


-- configure mason (nvim lsp installer)
mason.setup()
masonlsp.setup {
    ensure_installed = {
        "lua_ls",
        "clangd",
        "jdtls",
        "jedi_language_server"
    }
}

-- TODO: iterate over directory to find files
local function get_lsp_settings(server_name)
    local exists, module = pcall(require, "user.lsp-settings." .. server_name)

    if exists then
        return module
    end

    return {}
end

-- configure all the servers that are installed with mason
masonlsp.setup_handlers {
    function(server_name) -- the default handler
        lspconfig[server_name].setup {}
    end,
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup(get_lsp_settings("lua_ls"))
    end
}
