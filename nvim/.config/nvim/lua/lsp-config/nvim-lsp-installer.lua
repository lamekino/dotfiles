-- https://github.com/williamboman/nvim-lsp-installer/
local okay, installer = pcall(require, "nvim-lsp-installer")
if not okay then
    return
end

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("lsp-config.config").on_attach,
        capablities = require("lsp-config.config").capabilities,
    }

    -- (optional) Customize the options passed to the server
    if server.name == "sumneko_lua" then
        local sumneko_opts = require("lsp-config.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server.name == "jdtls" then
        local jdtls_opts = require("lsp-config.settings.jdtls")
        opts = vim.tbl_deep_extend("force", jdtls_opts, opts)
    end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
