local M = {}

M.settings = {
    Lua = {
        diagnostics = {
            enable = true,
            globals = {
                -- nvim
                "vim", "NONE",
                -- awesome wm
                "awesome", "client", "root"
            },
        },
        workspace = {
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
                ["/usr/share/awesome/lib"] = true
            },
        },
    },
}

return M
