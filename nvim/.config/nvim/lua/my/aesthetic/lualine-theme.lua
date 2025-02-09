local function theme_tweaks(theme)
    local is_dark = vim.o.background == "dark"
    local background = is_dark and "#141414" or "#efefef"

    local swap = theme.normal.a

    theme.normal.a = theme.visual.a
    theme.visual.a = swap

    local modes = { "normal", "visual", "insert", "replace", "command" }
    for _, mode in ipairs(modes) do
        theme[mode].c = {
            ["bg"] = background,
            ["fg"] = is_dark and theme[mode].a.bg or theme[mode].b.bg
        }
    end
end

local okay, theme = pcall(require, "lualine.themes.catppuccin-macchiato")
if okay then theme_tweaks(theme) end

return theme
