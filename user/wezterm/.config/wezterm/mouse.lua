function M(cfg, wt)
    cfg.mouse_bindings = {
        { -- windows terminal brainrot (right click paste)
            event = { Down = { streak = 1, button = 'Right' } },
            mods = 'NONE',
            action = wt.action.PasteFrom("Clipboard"),
        },
        { -- open links
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'SHIFT',
            action = wt.action.OpenLinkAtMouseCursor,
        },
    }
end

return M
