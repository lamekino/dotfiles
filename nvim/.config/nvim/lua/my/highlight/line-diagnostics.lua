local M = {}

M.create_callback = function(colormode)
    return function()
        local colors = {
            ["Error"] = { bg = "#51202A", fg = "#FF0000" },
            ["Warn"] = { bg = "#51412A", fg = "#FFA501" },
            ["Info"] = { bg = "#1E535D", fg = "#00FFFF" },
            ["Hint"] = { bg = "#1E205D", fg = "#9999FF" }
        }

        -- set up the number line to be highlighted with a color instead of
        -- using text
        for sign, highlight in pairs(colors) do
            local use_hl = highlight

            if colormode == "light" then
                local swap = highlight.bg
                use_hl.bg = use_hl.fg
                use_hl.fg = swap
            end

            vim.api.nvim_set_hl(0, "DiagnosticLineNr" .. sign, use_hl)

            vim.fn.sign_define("DiagnosticSign" .. sign, {
                text   = "",
                linehl = "",
                texthl = "DiagnosticSign" .. sign,
                numhl  = "DiagnosticLineNr" .. sign
            })
        end
    end
end

return M
