return {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    vim.fn.stdpath("config")
                }
            },
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
}
