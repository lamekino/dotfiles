local aug_tweaks = vim.api.nvim_create_augroup("ColorschemeTweaks", {
    clear = true
})

-- set autogroups for after the colorscheme is loaded
vim.api.nvim_create_autocmd("Colorscheme", {
    desc     = "lsp line number indicators",
    group    = aug_tweaks,
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

local function set_tweaked_hl(group_name, tweaks)
    local hl = vim.api.nvim_get_hl(0, { name = group_name })

    for field, tweak in pairs(tweaks) do
        hl[field] = tweak
    end

    vim.api.nvim_set_hl(0, group_name, hl)
end

vim.api.nvim_create_autocmd("Colorscheme", {
    desc     = "colorscheme highlight tweaks",
    group    = aug_tweaks,
    callback = function()
        set_tweaked_hl("Normal", {
            ["bg"] = "NONE"
        })

        for _, ugly_border in ipairs({ "FloatBorder", "WinSeparator" }) do
            set_tweaked_hl(ugly_border, {
                ["fg"] = "#353535",
                ["bg"] = "NONE"
            })
        end

        for _, ugly_italic in ipairs({ "Comment", "String" }) do
            set_tweaked_hl(ugly_italic, {
                ["italic"] = false
            })
        end

        for _, ugly_column in ipairs({ "ColorColumn", "CursorLine" }) do
            set_tweaked_hl(ugly_column, {
                ["fg"] = "NONE",
                ["bg"] = "#353535"
            })
        end

        vim.api.nvim_set_hl(0, "@parameter", {
            ["fg"] = "#ffaadb",
            ["bg"] = "NONE"
        })
        -- match the window background with normal
        vim.o.winhl = "Normal:Normal,NormalNC:Normal"
    end
})

-- set the colorscheme
vim.o.background = "dark"
pcall(function()
    vim.cmd.colorscheme("catppuccin-mocha")
end)
