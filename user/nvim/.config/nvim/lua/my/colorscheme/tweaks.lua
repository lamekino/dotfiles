local M = {}
local set = require("my.colorscheme.set")
local colors = require("my.colorscheme.colors")

local light_mode_tweaks = (function()
    set.groups({ "WinSeparator" }, {
        fg = "NONE",
        bg = colors.light.bg
    })
end)

local dark_mode_tweaks = (function()
    -- set.groups({ "Function" }, {
    --     fg = "#FFE188",
    --     bg = "NONE",
    -- })
    --
    -- set.groups({ "SpecialComment" }, {
    --     link = "MatchParen"
    -- })
end)

M.create_callback = (function(colormode)
    return function()
        local mode_tweaks = {
            ["dark"] = dark_mode_tweaks,
            ["light"] = light_mode_tweaks,

        }

        if mode_tweaks[colormode] ~= nil then
            mode_tweaks[colormode]()
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
    end
end)

return M
