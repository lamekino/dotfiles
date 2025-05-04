local function myevents(wt)
    return {
        ["format-window-title"] =
            (function()
                return "WezTerm"
            end),
        ["gui-startup"] =
            (function(cmd)
                local env = cmd or {}

                local _, _, window = wt.mux.spawn_window(env)
                local gui = window:gui_window()

                -- _ = window:spawn_tab(env)

                if gui then
                    gui:maximize()
                end
            end)
    }
end

return function(cfg, wt)
    for evname, callback in pairs(myevents(wt)) do
        wt.on(evname, callback)
    end

    -- cfg.enable_tab_bar = false
    cfg.hide_tab_bar_if_only_one_tab = true
    cfg.use_fancy_tab_bar = false

    -- m.enable_wayland = false
    -- m.window_decorations = "RESIZE"
    cfg.window_close_confirmation = 'NeverPrompt'

    cfg.window_padding = {
        left = 8,
        right = 8,
        top = 8,
        bottom = 8
    }
end
