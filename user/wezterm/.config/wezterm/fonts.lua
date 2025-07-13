local my_font = "Julia Mono"

local function my_font_configs(wt)
    local is_macos = string.find(wt.target_triple, "apple-darwin", 0, true)

    return {
        ["Julia Mono"] = {
            alias = is_macos and "JuliaMono",
            weight = "DemiBold",
            size = 20.0,
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
            width = 0.90,
            height = 1.00,
            disable_bold = true,
            disable_italic = true,
        }
    }
end

local function my_font_rules(wt, font_name, font_config)
    local bold_weight = font_config.disable_bold
        and font_config.weight
        or "Bold"

    return {
        { -- bold rule
            intensity = "Bold",
            italic = false,
            font = wt.font(font_name, {
                weight = bold_weight
            })
        },
        { -- italic rule
            intensity = "Normal",
            italic = true,
            font = wt.font(font_name, {
                italic = not font_config.disable_italic,
                weight = font_config.weight
            })
        },
        { -- bold + italic rule
            intensity = "Bold",
            italic = true,
            font = wt.font(font_name, {
                italic = not font_config.disable_italic,
                weight = bold_weight
            })
        }
    }
end

function M(cfg, wt)
    local font_config = my_font_configs(wt)[my_font]
    local font_name = font_config.alias ~= nil and font_config.alias or my_font

    cfg.font_size = font_config.size
    cfg.cell_width = font_config.width
    cfg.line_height = font_config.height
    cfg.font_rules = my_font_rules(wt, font_name, font_config)

    cfg.font = wt.font_with_fallback({
        { family = font_name, weight = font_config.weight },
        "Apple Color Emoji",
        "Noto Sans Mono CJK JP"
    })
end

return M
