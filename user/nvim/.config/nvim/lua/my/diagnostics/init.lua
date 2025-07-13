local M = {}

function M.setup(colormode)
    vim.diagnostic.config {
        virtual_text = false,
        signs = require("my.diagnostics.signs"):create_signs(colormode),
        underline = false,
        update_in_insert = false,
        severity_sort = true,

        float = {
            style = "rounded",
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            source = true,
            header = "",
            prefix = "",
            focusable = false,
            severity_sort = true
        },
    }

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        callback = function()
            if vim.fn.mode() ~= "i" then
                vim.diagnostic.open_float(nil, { focus = false })
            end
        end
    })
end

return M
