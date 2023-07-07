local cmp = require('cmp')
local border = require("user.aesthetics.square_border")
local lsp = require('lsp-zero').preset {
    manage_nvim_cmp = {
        set_sources = 'recommended',
        set_extra_mappings = true
    }
}

-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

local disabled_autofmt = {
    ["clangd"] = true
}

local function lsp_keybinds(buffer)
    local lsp_nmap = function(keys, callback)
        local opts = { buffer = buffer, noremap = true }
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

lsp.ensure_installed {
    "lua_ls",
    "clangd",
    "jdtls",
    "jedi_language_server"
}

lsp.on_attach(function(client, bufnr)
    lsp_keybinds(bufnr)

    -- configure function signature helper
    require("lsp_signature").on_attach({
        bind = true,
        handler_opts = {
            border = border
        },
    }, bufnr)

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, {
            border = border
        })

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = border,
        })

    local augroup = vim.api.nvim_create_augroup("MyLspConfig", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        desc = "autoformat with lsp",
        callback = function()
            vim.lsp.buf.format {
                filter = function(c)
                    return disabled_autofmt[c.name] == nil
                end
            }
        end
    })
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
