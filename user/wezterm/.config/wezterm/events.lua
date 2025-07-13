local window_title = "WezTerm"
local default_tab_title = "untitled"

local function my_events(wt)
    return {
        ["format-window-title"] = -- (tab, pane, tabs, panes, config)
            (function()
                return window_title
            end),
        ["format-tab-title"] = -- (tab, tabs, panes, config, hover, max_width)
            (function(tab)
                local has_title = tab.tab_title ~= ""

                return string.format(
                    " %d:%s ",
                    tab.tab_index + 1,
                    has_title and tab.tab_title or default_tab_title
                )
            end),
        ["gui-startup"] = -- (cmd)
            (function(cmd)
                local _, pane, _ = wt.mux.spawn_window(cmd or {})

                -- set the default tab title when loading zshrc
                -- BUG: this doesn't work with more than one window
                pane:send_text("\n")
            end)
    }
end

function M(_, wt)
    for evname, callback in pairs(my_events(wt)) do
        wt.on(evname, callback)
    end
end

return M
