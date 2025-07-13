local ok1, ls = pcall(require, "luasnip")
local ok2, types = pcall(require, "luasnip.util.types")
local ok3, extras = pcall(require, "luasnip.extras")
local ok4, extras_fmt = pcall(require, "luasnip.extras.fmt")

if not (ok1 and ok2 and ok3 and ok4) then
    return
end

local M = {}

function M.setup()
    local ls_configs = { "lua" }

    ls.config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true
    }

    for _, config in ipairs(ls_configs) do
        local module = "my.snippets.filetype." .. config
        local has_config, init_from_context = pcall(require, module)

        if not has_config then
            error("no luasnip config for " .. config)
        else
            init_from_context({
                s = ls.s,
                i = ls.insert_node,
                t = ls.text_node,
                c = ls.choice_node,
                rep = extras.rep,
                fmt = extras_fmt.fmt,
                fmta = extras_fmt.fmta
            })
        end
    end
end

return M
