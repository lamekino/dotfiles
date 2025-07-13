function M(cfg, _)
    -- window
    local padding = 8

    cfg.window_close_confirmation = "NeverPrompt"
    cfg.window_decorations = "RESIZE"
    cfg.window_padding = {
        left = padding,
        right = padding,
        top = padding,
        bottom = padding
    }

    -- tabs
    cfg.enable_tab_bar = true
    cfg.use_fancy_tab_bar = false
    cfg.tab_bar_at_bottom = true
    cfg.hide_tab_bar_if_only_one_tab = false
end

return M
