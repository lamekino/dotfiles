local M = {}

local function hi(name, groups)
    vim.api.nvim_set_hl(0, name, groups)
end

local function lsp_colors()
    -- Setting up LSP number line diagnostics
    hi("DiagnosticLineNrError", { bg = "#51202A", fg = "#FF0000" })
    hi("DiagnosticLineNrWarn", { bg = "#51412A", fg = "#FFA501" })
    hi("DiagnosticLineNrInfo", { bg = "#1E535D", fg = "#00FFFF" })
    hi("DiagnosticLineNrHint", { bg = "#1E205D", fg = "#0000FF" })

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

    -- set autogroups for after the colorscheme is loaded
    vim.api.nvim_create_autocmd("Colorscheme", {
        desc     = "lsp line number indicators",
        callback = lsp_colors
    })

    vim.api.nvim_create_autocmd("Colorscheme", {
        desc     = "colorscheme highlight tweaks",
        callback = function()
            hi("Normal", { bg = "NONE" })
            hi("FloatBorder", { fg = "#353535", bg = "NONE" })
            hi("WinSeparator", { fg = "#353535", bg = "NONE" })
            -- hi("Whitespace", { fg = "#353535", bg = "NONE" })

            -- match the window background with normal
            vim.o.winhl = "Normal:Normal,NormalNC:Normal"
        end
    })

    vim.api.nvim_create_autocmd("ColorschemePre", {
        desc     = "sets global colorscheme variables",
        callback = function()
            -- Tokyonight
            vim.g.tokyonight_style       = "night"
            vim.g.tokyonight_transparent = true

            -- Catpuccin
            vim.g.catppuccin_flavour = "mocha"
        end
    })

    -- Set the colorscheme
    vim.cmd("colorscheme " .. colorscheme)
end

return M
