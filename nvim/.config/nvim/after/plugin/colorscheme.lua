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

local function set_tweaked_hl(group_name, tweaks)
    local hl = vim.api.nvim_get_hl(0, { name = group_name })

    for field, tweak in pairs(tweaks) do
        hl[field] = tweak
    end

    vim.api.nvim_set_hl(0, group_name, hl)
end

local function set_tweaks(group_names, new_colors)
    for _, group in ipairs(group_names) do
        set_tweaked_hl(group, new_colors)
    end
end

vim.api.nvim_create_autocmd("Colorscheme", {
    desc     = "colorscheme highlight tweaks",
    group    = aug_tweaks,
    callback = function()
        set_tweaks({ "Normal" }, {
            ["bg"] = "NONE"
        })

        set_tweaks({ "Comment", "String" }, {
            ["italic"] = false
        })

        set_tweaks({ "FloatBorder", "WinSeparator" }, {
            ["fg"] = "#353535",
            ["bg"] = "NONE"
        })

        set_tweaks({ "ColorColumn", "CursorLine" }, {
            ["fg"] = "NONE",
            ["bg"] = "#353535"
        })

        set_tweaks({ "@text.todo", "Todo" }, {
            ["fg"] = "NONE",
            ["bg"] = "NONE"
        })

        set_tweaks({ "@parameter" }, {
            ["fg"] = "#ffaadb",
            ["bg"] = "NONE"
        })

        set_tweaks({ "Function" }, {
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
