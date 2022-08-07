local M = {}

M.settings = {
    Lua = {
        diagnostics = {
            globals = { "vim", "NONE" },
        },
        workspace = {
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
            },
        },
    },
}

return M
