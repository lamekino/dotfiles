local M = {}

local function hl(name, groups)
    vim.api.nvim_set_hl(0, name, groups)
end

local function lsp_colors()
    -- Setting up LSP number line diagnostics
    hl("DiagnosticLineNrError", { bg = "#51202A", fg = "#FF0000" })
    hl("DiagnosticLineNrWarn", { bg = "#51412A", fg = "#FFA501" })
    hl("DiagnosticLineNrInfo", { bg = "#1E535D", fg = "#00FFFF" })
    hl("DiagnosticLineNrHint", { bg = "#1E205D", fg = "#0000FF" })

    -- Set up the number line to be highlighted with a color instead of using
    -- text
    for _, sign in ipairs { "Error", "Warn", "Info", "Hint" } do
        vim.fn.sign_define("DiagnosticSign" .. sign, {
            text   = "",
            linehl = "",
            texthl = "DiagnosticSign" .. sign,
            numhl  = "DiagnosticLineNr" .. sign
        })
    end

end

M.setup = function(colorscheme, mode)
    vim.o.background = mode

    -- match the window background with normal
    vim.o.winhl = "Normal:Normal"

    -- set autogroups for after the colorscheme is loaded
    vim.api.nvim_create_autocmd("Colorscheme", {
        desc     = "lsp line number indicators",
        callback = lsp_colors
    })

    vim.api.nvim_create_autocmd("Colorscheme", {
        desc     = "colorscheme highlight tweaks",
        callback = function()
            hl("Normal", { bg = "NONE" }) -- transparent bg
            hl("Whitespace", { fg = "#353535" }) -- listchar colors
        end
    })

    -- Set the colorscheme
    vim.cmd("colorscheme " .. colorscheme)
end

return M
