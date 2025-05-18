-- set up the number line to be highlighted with a color instead of
-- using text
local M = {}

local colors = {
    ["Error"] = { bg = "#51202A", fg = "#FF0000" },
    ["Warn"] = { bg = "#51412A", fg = "#FFA501" },
    ["Info"] = { bg = "#1E535D", fg = "#00FFFF" },
    ["Hint"] = { bg = "#1E205D", fg = "#9999FF" }
}

local function create_signs(colormode)
    local sign_config = {
        text = {},
        linehl = {},
        numhl = {},
    }

    for sign, highlight in pairs(colors) do
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

function M.setup(colormode)
    vim.diagnostic.config {
        virtual_text     = false,
        signs            = create_signs(colormode),
        underline        = false,
        update_in_insert = false,
        severity_sort    = true,

        float            = {
            style         = "rounded",
            border        = require("my.aesthetic.square-border"),
            source        = "always",
            header        = "",
            prefix        = "",
            focusable     = false,
            severity_sort = true
        },
    }
end

return M
