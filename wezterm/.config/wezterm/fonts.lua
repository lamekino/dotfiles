local my_font = "Julia Mono"

local function my_font_configs(wt)
    local is_macos = string.find(wt.target_triple, "apple-darwin", 0, true)

    return {
        ["Julia Mono"] = {
            alias = is_macos and "JuliaMono",
            weight = "DemiBold",
            size = 19.5,
            width = 0.95,
            height = 1.10
        },

        ["IBM Plex Mono"] = {
            weight = "Medium",
            size = 19.5,
            width = 0.95,
            height = 1.00
        },

        ["Fira Mono"] = {
            weight = "Medium",
            size = 20.5,
            width = 0.95,
            height = 1.00
        },

        ["Fixedsys Excelsior 3.01"] = {
            weight = "Regular",
            size = 22.5,
            width = 0.95,
            height = 1.10,
            disable_bold_italic = true
        }
    }
end

local function font_rules_enable_bold_italic(wt, family_name)
    return {
        {
            intensity = "Bold",
            italic = false,
            font = wt.font(family_name, { weight = "Bold" })
        },
        {
            intensity = "Bold",
            italic = true,
            font = wt.font(family_name, { weight = "Bold", italic = true })
        }
    }
end

local function font_rules_disable_bold_italic(wt, family_name)
    return {
        {
            intensity = "Bold",
            italic = true,
            font = wt.font(family_name, { weight = "Regular" })
        },
        {
            intensity = "Bold",
            italic = false,
            font = wt.font(family_name, { weight = "Regular" })
        },
        {
            intensity = "Normal",
            italic = true,
            font = wt.font(family_name, { weight = "Regular" })
        }
    }
end

function M(cfg, wt)
    local font = my_font_configs(wt)[my_font]
    local family = font.alias ~= nil and font.alias or my_font

    cfg.font_size = font.size
    cfg.cell_width = font.width
    cfg.line_height = font.height

    cfg.font_rules = font.disable_bold_italic ~= nil
        and font_rules_disable_bold_italic(wt, family)
        or font_rules_enable_bold_italic(wt, family)

    cfg.font = wt.font_with_fallback({
        { family = family, weight = font.weight },
        "Apple Color Emoji",
        "Noto Sans Mono CJK JP"
    })
end

return M
