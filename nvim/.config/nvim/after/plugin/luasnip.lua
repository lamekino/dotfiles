local okay, ls = pcall(require, "luasnip")
if not okay then return end

local okay, types = pcall(require, "luasnip.util.types")
if not okay then return end

local okay, extras = pcall(require, "luasnip.extras")
if not okay then return end

local okay, extras_fmt = pcall(require, "luasnip.extras.fmt")
if not okay then return end

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

local rep = extras.rep
local fmt = extras_fmt.fmt
local fmta = extras_fmt.fmta

local newline = function(text)
    return t { "", text }
end

ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true
}

ls.add_snippets("lua", {
    s("req",
        fmt("local {} = require(\"{}\")",
            { i(1), rep(1) })
    ),

    s("lf",
        fmt("local {} = function({})\n    {}\nend",
            { i(1), i(2), i(3, "return") })
    )
})

ls.add_snippets("c", {
    s("ll", { t("long long ") }),
    s("ifunc",
        fmta("int <>(<>) {\n    <>\n}",
            {
                i(1, "func"),
                i(2),
                i(3)
            })
    ),
    s("fmal",
        fmta("<> *<> = malloc(sizeof(<>) * <>);\n<>\nfree(<>);",
            {
                i(1, "int"),
                i(2, "xs"),
                rep(1),
                i(3, "n"),
                i(4),
                rep(2)
            })
    ),
    s("rmal",
        fmta("<> *<> = malloc(sizeof(<>) * <>);\n<>\nreturn<>;",
            {
                i(1, "int"),
                i(2, "xs"),
                rep(1),
                i(3, "n"),
                i(4),
                rep(2)
            })
    ),
    s("mainf",
        fmta("int main(int argc, char **argv) {\n    <>\n    return 0;\n}",
            { i(1) })
    )
})

ls.add_snippets("haskell", {
    s("atob",
        fmt("{} :: {} -> {}\n{} {}= {}",
            { i(1, "f"), i(2, "a"), i(3, "b"), rep(1), i(4), i(5) })
    ),
    s("dwrap",
        fmt("data {} = {} a", { i(1), rep(1) })
    )
})

ls.add_snippets("java", {
    s("printout",
        fmt("System.out.println({});\n", i(1, "\"\""))
    ),
    s("printerr",
        fmt("System.err.println({});\n", i(1, "\"\""))
    ),
})
