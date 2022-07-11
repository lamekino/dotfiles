local function set_lsp_opts(name, opts)
    local okay, ext_opts = pcall(require, "user.lsp.settings." .. name)

    -- if external config doesn't exist, use default values
    -- or if the ext_opts is empty
    if not okay or ext_opts == true then
        return opts
    end

    return vim.tbl_deep_extend("force", ext_opts, opts);
end

-- FIXME: on_server_ready is deprecated, see:
-- https://github.com/williamboman/nvim-lsp-installer/discussions/636
require("nvim-lsp-installer").on_server_ready(function(server)
    local opts = {
        on_attach = require("user.lsp.config").on_attach,
        capablities = require("user.lsp.config").capabilities,
    }

    opts = set_lsp_opts(server.name, opts)
    server:setup(opts)
end)
