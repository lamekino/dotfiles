local window_title = "WezTerm"

local function my_events(wt)
    return {
        ["format-window-title"] =
            (function()
                return window_title
            end),
        ["format-tab-title"] = -- (tab, tabs, panes, config, hover, max_width)
            (function(tab, ...)
                local has_title = tab.tab_title ~= ""

                return string.format(
                    " %d: %s ",
                    tab.tab_index + 1,
                    has_title and tab.tab_title or "untitled"
                )
            end),
        ["gui-startup"] =
            (function(cmd)
                local env = cmd or {}
                local _, pane, _ = wt.mux.spawn_window(env)

                -- BUG: this doesn't work with more than one window
                pane:send_text("\n")
            end)
    }
end

return function(cfg, wt)
    -- window
    local padding = 8

    cfg.window_close_confirmation = 'NeverPrompt'
    cfg.window_decorations = 'RESIZE'
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

    -- set events
    for evname, callback in pairs(my_events(wt)) do
        wt.on(evname, callback)
    end
end
