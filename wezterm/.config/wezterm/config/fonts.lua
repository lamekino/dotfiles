local font_config = {
    plex = {
        family = "IBM Plex Mono Text",
        weight = "Regular",
        size = 17.5,
        width = 0.95,
        height = 1.00
    },

    juila = {
        family = "Julia Mono",
        weight = "Medium",
        size = 17.5,
        width = 0.95,
        height = 1.10
    }
}

return function(cfg, wt)
    local font = font_config.juila

    cfg.font_size = font.size
    cfg.cell_width = font.width
    cfg.line_height = font.height

    cfg.font = wt.font_with_fallback({
        {
            family = font.family,
            weight = font.weight
        },
        { family = "Noto Sans Mono CJK JP" },
    })

    cfg.font_rules = {
        {
            intensity = "Bold",
            italic = false,
            font = wt.font(font.family, { weight = "Bold" })
        },
        {
            intensity = "Bold",
            italic = true,
            font = wt.font(font.family, { italic = true, weight = "Bold" })
        }
    }
end
