local M = {}
local util = require("my.highlight.functions")

M.callback = function()
    util.set_groups({ "Normal" }, {
        ["bg"] = "NONE"
    })

    util.set_groups({ "Comment", "String" }, {
        ["italic"] = false
    })

    util.set_groups({ "FloatBorder", "WinSeparator" }, {
        ["fg"] = "#353535",
        ["bg"] = "NONE"
    })

    util.set_groups({ "ColorColumn", "CursorLine" }, {
        ["fg"] = "NONE",
        ["bg"] = "#353535"
    })

    util.set_groups({ "@text.todo", "Todo" }, {
        ["fg"] = "NONE",
        ["bg"] = "NONE"
    })

    util.set_groups({ "@parameter" }, {
        ["fg"] = "#ffaadb",
        ["bg"] = "NONE"
    })

    util.set_groups({ "Function" }, {
        ["fg"] = "#a5bbdd"
    })

    util.set_groups({ "StatusLine", "StatusLineNC" }, {
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

return M
