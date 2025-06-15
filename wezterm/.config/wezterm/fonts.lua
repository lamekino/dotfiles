local function my_fonts(wt)
    local is_macos =
        wt.target_triple == "aarch64-apple-darwin" or
        wt.target_triple == "x86_64-apple-darwin"

    return {
        plex = {
            family = "IBM Plex Mono",
            weight = "Medium",
            size = 17.0,
            width = 0.95,
            height = 1.00
        },

        juila = {
            -- font config on macOS has no space for some reason
            family = is_macos and "JuliaMono" or "Julia Mono",
            weight = "Medium",
            size = 19.5,
            width = 0.95,
            height = 1.10
        }
    }
end

local function fallback(family, weight)
    return {
        family = family,
        weight = weight
    }
end

return function(cfg, wt)
    local font = my_fonts(wt).juila

    cfg.font_size = font.size
    cfg.cell_width = font.width
    cfg.line_height = font.height

    cfg.font = wt.font_with_fallback({
        fallback(font.family, font.weight),
        fallback("Apple Color Emoji", "Regular"),
        fallback("Noto Sans Mono CJK JP", "Regular")
    })

    cfg.font_rules = {
        {
            intensity = "Bold",
            italic = true,
            font = wt.font(font.family, { weight = "Bold", italic = true })
        },
        {
            intensity = "Bold",
            italic = false,
            font = wt.font(font.family, { weight = "Bold" })
        }
    }
end
