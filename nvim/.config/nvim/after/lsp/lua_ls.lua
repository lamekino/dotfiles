return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    vim.fn.stdpath("config")
                }
            },
            diagnostics = {
                globals = { "vim" },
            },
            format = {
                defaultConfig = {
                    quote_style = "double",
                    align_continuous_assign_statement = "false",
                    align_continuous_rect_table_field = "false",
                    align_array_table = "false",
                }
            }
        },
    },
}
