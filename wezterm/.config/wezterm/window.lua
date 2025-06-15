local window_title = "WezTerm"

local function my_events(wt)
    return {
        ["format-window-title"] =
            (function()
                return window_title
            end),
        ["format-tab-title"] = -- (tab, tabs, panes, config, hover, max_width)
            (function(tab, ...)
                return string.format(
                    " %d: %s ",
                    tab.tab_index + 1, tab.tab_title
                )
            end),
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
