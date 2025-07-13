local M = {}
local set = require("my.colorscheme.set")

local function light_mode_tweaks()
    -- this should be in init.lua, and might have a ascii default instead
    vim.opt.fillchars = {
        vert = "|",
        horiz = "-",
        horizup = "+",
        horizdown = "+",
        vertleft = "+",
        vertright = "+",
        verthoriz = "+",
    }

    set.groups({ "WinSeparator" }, {
        ["fg"] = "NONE",
        ["bg"] = vim.api.nvim_get_hl(0, { name = "ColorColumn" }).bg,
    })
end

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

    set.groups({ "@parameter" }, {
        ["fg"] = "#ffaadb",
        ["bg"] = "NONE"
    })
end

M.create_callback = function(colormode)
    return function()
        local mode_tweaks = {
            ["dark"] = dark_mode_tweaks,
            ["light"] = light_mode_tweaks,

        }

        if mode_tweaks[colormode] ~= nil then
            mode_tweaks[colormode]()
        end

        set.groups({ "Normal" }, { ["bg"] = "NONE" })

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
end

return M
