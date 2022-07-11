local snip = require("luasnip")
-- local types = require("luasnip.util.types")

snip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true
}

snip.snippets = {
    lua = {
        snip.parser.parse_snippet("lf", "local $1 = function ($2)\n    $0\nend"),
    },
}
