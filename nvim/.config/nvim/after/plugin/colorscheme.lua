local my = require("my.highlight")

local aug_tweaks = vim.api.nvim_create_augroup("ColorschemeTweaks", {
    clear = true
})

-- set autogroups for after the colorscheme is loaded
vim.api.nvim_create_autocmd("Colorscheme", {
    desc     = "lsp line number indicators",
    group    = aug_tweaks,
    callback = function()
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
})

vim.api.nvim_create_autocmd("Colorscheme", {
    desc     = "colorscheme highlight tweaks",
    group    = aug_tweaks,
    callback = function()
        my.set_groups({ "Normal" }, {
            ["bg"] = "NONE"
        })

        my.set_groups({ "Comment", "String" }, {
            ["italic"] = false
        })

        my.set_groups({ "FloatBorder", "WinSeparator" }, {
            ["fg"] = "#353535",
            ["bg"] = "NONE"
        })

        my.set_groups({ "ColorColumn", "CursorLine" }, {
            ["fg"] = "NONE",
            ["bg"] = "#353535"
        })

        my.set_groups({ "@text.todo", "Todo" }, {
            ["fg"] = "NONE",
            ["bg"] = "NONE"
        })

        my.set_groups({ "@parameter" }, {
            ["fg"] = "#ffaadb",
            ["bg"] = "NONE"
        })

        my.set_groups({ "Function" }, {
            ["fg"] = "#a5bbdd"
        })

        -- match the window background with normal
        vim.o.winhl = "Normal:Normal,NormalNC:Normal"
    end
})

-- set the colorscheme
vim.o.background = "dark"
pcall(function()
    vim.cmd.colorscheme("catppuccin-macchiato")
end)
