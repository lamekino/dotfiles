local ls = require("luasnip")
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
-- local types = require("luasnip.util.types")

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
