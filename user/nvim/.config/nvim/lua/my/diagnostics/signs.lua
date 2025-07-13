local M = {
    colors = {
        ["Error"] = { bg = "#51202A", fg = "#FF0000" },
        ["Warn"] = { bg = "#51412A", fg = "#FFA501" },
        ["Info"] = { bg = "#1E535D", fg = "#00FFFF" },
        ["Hint"] = { bg = "#1E205D", fg = "#9999FF" }
    }
}

function M:create_signs(colormode)
    local sign_config = {
        text = {},
        linehl = {},
        numhl = {},
    }

    for sign, highlight in pairs(self.colors) do
        local lvl = vim.diagnostic.severity[string.upper(sign)]
        local use = highlight

        -- swap bg/fg in lightmode
        if colormode == "light" then
            use.fg, use.bg = use.bg, use.fg
        end

        vim.api.nvim_set_hl(0, "DiagnosticSign" .. sign, use)
        vim.api.nvim_set_hl(0, "DiagnosticLineNr" .. sign, use)

        sign_config.text[lvl] = ""
        sign_config.linehl[lvl] = "NONE"
        sign_config.numhl[lvl] = "DiagnosticLineNr" .. sign
    end

    return sign_config
end

return M
