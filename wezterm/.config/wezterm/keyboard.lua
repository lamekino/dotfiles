function M(cfg, wt)
    cfg.keys = {
        { -- make <C-[> to send escape code (Esc), like older terminals
            key = '[',
            mods = 'CTRL',
            action = wt.action.SendKey({ key = "Escape" })
        },
        { -- reload config
            key = 'r',
            mods = 'CMD|SHIFT',
            action = wt.action.ReloadConfiguration,
        },
        { -- disable annoying behavior
            key = ' ',
            mods = 'SHIFT',
            action = wt.action.Nop
        },
    }

    -- macos cmdkeys -> altkeys, im not breaking this habit
    for number_key = 0, 9 do
        table.insert(cfg.keys, {
            mods = 'SUPER',
            key = tostring(number_key),
            action = wt.action.SendKey({
                mods = 'ALT',
                key = tostring(number_key)
            })
        })
    end
end

return M
