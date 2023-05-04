vim.api.nvim_create_augroup("ColorschemeTweaks", { clear = true })

-- set autogroups for after the colorscheme is loaded
vim.api.nvim_create_autocmd("Colorscheme", {
    desc     = "lsp line number indicators",
    group    = "ColorschemeTweaks",
    callback = function()
        local colors = {
            ["Error"] = { fg = "#51202A", bg = "#FF0000" },
            ["Warn"] = { fg = "#51412A", bg = "#FFA501" },
            ["Info"] = { fg = "#1E535D", bg = "#00FFFF" },
            ["Hint"] = { fg = "#1E205D", bg = "#0000FF" }
        }

        -- set up the number line to be highlighted with a color instead of using
        -- text
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
})

vim.api.nvim_create_autocmd("Colorscheme", {
    desc     = "colorscheme highlight tweaks",
    group    = "ColorschemeTweaks",
    callback = function()
        vim.api.nvim_set_hl(0, "Normal", {
            bg = "NONE"
        })
        vim.api.nvim_set_hl(0, "FloatBorder", {
            fg = "#353535",
            bg = "NONE"
        })
        vim.api.nvim_set_hl(0, "WinSeparator", {
            fg = "#353535",
            bg = "NONE"
        })

        -- match the window background with normal
        vim.o.winhl = "Normal:Normal,NormalNC:Normal"
    end
})

vim.api.nvim_create_autocmd("ColorschemePre", {
    desc     = "sets global colorscheme variables",
    group    = "ColorschemeTweaks",
    callback = function()
        -- Tokyonight
        vim.g.tokyonight_style       = "night"
        vim.g.tokyonight_transparent = true

        -- Catpuccin
        vim.g.catppuccin_flavour = "mocha"
    end
})

-- set the colorscheme
vim.o.background = "dark"
vim.cmd("colorscheme melange")
