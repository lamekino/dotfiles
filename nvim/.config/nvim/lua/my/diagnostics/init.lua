local M = {}

function M.setup(colormode)
    require("my.diagnostics.hover")

    vim.diagnostic.config {
        virtual_text = false,
        signs = require("my.diagnostics.signs"):create_signs(colormode),
        underline = false,
        update_in_insert = false,
        severity_sort = true,

        float = {
            style = "rounded",
            border = require("my.aesthetic.square-border"),
            source = "always",
            header = "",
            prefix = "",
            focusable = false,
            severity_sort = true
        },
    }
end

return M
