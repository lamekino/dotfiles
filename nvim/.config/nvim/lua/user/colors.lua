local M = {}

local function hl(name, groups)
    vim.api.nvim_set_hl(0, name, groups)
end

local function lsp_colors()
    -- Setting up LSP number line diagnostics
    hl("DiagnosticLineNrError", { bg = "#51202A", fg = "#FF0000" })
    hl("DiagnosticLineNrWarn",  { bg = "#51412A", fg = "#FFA501" })
    hl("DiagnosticLineNrInfo",  { bg = "#1E535D", fg = "#00FFFF" })
    hl("DiagnosticLineNrHint",  { bg = "#1E205D", fg = "#0000FF" })

    -- Set up the number line to be highlighted with a color instead of using
    -- text
    for _, sign in ipairs {"Error", "Warn", "Info", "Hint"} do
        vim.fn.sign_define("DiagnosticSign" .. sign, {
            text = "",
            linehl = "",
            texthl = "DiagnosticSign" .. sign,
            numhl = "DiagnosticLineNr" .. sign
        })
    end
end

local function tweak_highlights(colorscheme)
    if colorscheme == "catppuccin" then
        hl("Normal", { bg = "NONE" })
    elseif colorscheme == "jellybeans-nvim" then
        hl("Whitespace", { fg = "#313131" }) -- listchar colors
    end
end

M.setup = function(colorscheme, mode)
    -- Vim settings
    vim.o.background = mode

    if colorscheme == "tokyonight" then
        vim.g.tokyonight_style = "night"
        vim.g.tokyonight_italic_keywords = false
        vim.g.tokyonight_italic_comments = false
        vim.g.tokyonight_transparent = true
    elseif colorscheme == "gruvbox" then
        vim.g.gruvbox_transparent_bg = 1
        vim.g.gruvbox_contrast_dark = "hard"
        vim.g.gruvbox_contrast_light = "hard"
    elseif colorscheme == "catppuccin" then
        vim.g.catppuccin_flavour = "mocha"
    end

    -- Set the colorscheme
    vim.cmd("colorscheme " .. colorscheme)

    -- Set the highlights
    lsp_colors()
    tweak_highlights(colorscheme)
end

return M