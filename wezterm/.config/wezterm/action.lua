return function(cfg, wt)
    cfg.keys = {
        {
            key = '[',
            mods = 'CTRL',
            action = wt.action.SendKey({ key = "Escape" })
        },
        {
            key = ' ',
            mods = 'SHIFT',
            action = wt.action.Nop
        },
    }

    cfg.mouse_bindings = {
        {
            event = { Down = { streak = 1, button = 'Right' } },
            mods = 'NONE',
            action = wt.action.PasteFrom("Clipboard"),
        },
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'SHIFT',
            action = wt.action.OpenLinkAtMouseCursor,
        },
    }
end
