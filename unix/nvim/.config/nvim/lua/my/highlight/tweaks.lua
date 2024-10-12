local M = {}
local set = require("my.highlight.set")

local function dark_mode_tweaks()
    set.groups({ "Normal" }, {
        ["bg"] = "NONE"
    })

    set.groups({ "FloatBorder", "WinSeparator" }, {
        ["fg"] = "#353535",
        ["bg"] = "NONE"
    })

    set.groups({ "ColorColumn", "CursorLine" }, {
        ["fg"] = "NONE",
        ["bg"] = "#353535"
    })

    set.groups({ "StatusLine", "StatusLineNC" }, {
        ["bg"] = "NONE"
    })

    set.groups({ "Function" }, {
        ["fg"] = "#a5bbdd"
    })

    set.groups({ "@parameter" }, {
        ["fg"] = "#ffaadb",
        ["bg"] = "NONE"
    })
end

local function light_mode_tweaks()
    -- needs terminal to be light!
    set.groups({ "Normal" }, {
        ["bg"] = "NONE"
    })
end

M.create_callback = function(colormode)
    return function()
        if colormode == "dark" then
            dark_mode_tweaks()
        else
            light_mode_tweaks()
        end

        set.groups({ "Comment", "String" }, {
            ["italic"] = false
        })

        set.groups({ "@text.todo", "Todo" }, {
            ["fg"] = "NONE",
            ["bg"] = "NONE"
        })

        -- match the window background with normal
        vim.o.winhl = "Normal:Normal,NormalNC:Normal"

        -- TODO: TELESCOPE DOES NOT WANNA BE TRANSPARENT
        -- vim.o.winhl = weird {
        --     "TelescopeNormal",
        --     "TelescopeBorder",
        --     "TelescopeSelectionCaret",
        --     "TelescopeMatching",
        --     "TelescopePromptNormal",
        --     "TelescopePromptTitle",
        --     "TelescopePromptPrefix",
        --     "TelescopePromptBorder",
        --     "TelescopePreviewTitle",
        --     "TelescopePreviewBorder",
        --     "TelescopeResultsTitle",
        --     "TelescopeResultsBorder"
        -- }
    end
end

return M
