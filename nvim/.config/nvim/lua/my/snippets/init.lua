local ok1, ls = pcall(require, "luasnip")
local ok2, types = pcall(require, "luasnip.util.types")
local ok3, extras = pcall(require, "luasnip.extras")
local ok4, extras_fmt = pcall(require, "luasnip.extras.fmt")

if not (ok1 and ok2 and ok3 and ok4) then
    return
end

local M = {}

function M.setup()
    local languages = { "lua" }

    local ctx = {
        s = ls.s,
        i = ls.insert_node,
        t = ls.text_node,
        c = ls.choice_node,
        rep = extras.rep,
        fmt = extras_fmt.fmt,
        fmta = extras_fmt.fmta
    }

    ls.config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true
    }

    for _, lang in ipairs(languages) do
        local has_config, init = pcall(require, "my.snippets." .. lang)

        if has_config then
            ls.add_snippets(lang, init(ctx))
        else
            error("no luasnip config for " .. lang)
        end
    end

end

return M
