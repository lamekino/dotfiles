local function my_events(wt)
    return {
        ["format-window-title"] =
            (function()
                return "WezTerm"
            end),
        ["gui-startup"] =
            (function(cmd)
                local env = cmd or {}
                local _, pane, _ = wt.mux.spawn_window(env)

                pane:send_text("\n") -- skip set title prompt (zshrc)
            end)
    }
end

return function(cfg, wt)
    cfg.tab_bar_at_bottom = true
    cfg.use_fancy_tab_bar = false
    cfg.window_close_confirmation = 'NeverPrompt'
    -- cfg.hide_tab_bar_if_only_one_tab = true
    -- cfg.enable_tab_bar = false
    -- cfg.enable_wayland = false

    local pad = 8
    cfg.window_padding = {
        left = pad,
        right = pad,
        top = pad,
        bottom = pad
    }

    for evname, callback in pairs(my_events(wt)) do
        wt.on(evname, callback)
    end
end
