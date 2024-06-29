local M = {}

M.callback = function()
    local colors = {
        ["Error"] = { bg = "#51202A", fg = "#FF0000" },
        ["Warn"] = { bg = "#51412A", fg = "#FFA501" },
        ["Info"] = { bg = "#1E535D", fg = "#00FFFF" },
        ["Hint"] = { bg = "#1E205D", fg = "#9999FF" }
    }

    -- set up the number line to be highlighted with a color instead of
    -- using text
    for sign, highlight in pairs(colors) do
        vim.api.nvim_set_hl(0, "DiagnosticLineNr" .. sign, highlight)

        vim.fn.sign_define("DiagnosticSign" .. sign, {
            text   = "",
            linehl = "",
            texthl = "DiagnosticSign" .. sign,
            numhl  = "DiagnosticLineNr" .. sign
        })
    end
end

return M
