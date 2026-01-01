local colormode = "dark"

local light_opacity = 0.89
local light_tweaks = { background = "#FFFFFF", foreground = "#404040" }

local dark_opacity = 0.90
local dark_tweaks = {}

local set_theme = (function(cfg, theme, tweaks, opacity)
    return function()
        for k, v in pairs(tweaks) do
            theme[k] = v
        end

        cfg.window_background_opacity = opacity
        cfg.colors = theme
    end
end)

local M = (function(cfg, wt)
    local builtins = wt.get_builtin_color_schemes()

    local light_theme = builtins["Catppuccin Latte"]
    local dark_theme = builtins["Jellybeans"]

    local callback = {
        ["light"] = set_theme(cfg, light_theme, light_tweaks, light_opacity),
        ["dark"] = set_theme(cfg, dark_theme, dark_tweaks, dark_opacity)
    }

    if callback[colormode] == nil then
        error(string.format("invalid colormode '%s'", colormode))
        return
    end

    cfg.set_environment_variables["VIM_COLORMODE"] = colormode

    callback[colormode]()
end)

return M
