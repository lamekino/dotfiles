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

-- this is broken and idk why :(
vim.keymap.set({ "i" }, "<C-k>", function ()
    require("luasnip.extras.select_choice")()
end, { silent = true })

vim.keymap.set({ "i" }, "<C-j>", function ()
    if snip.jumpable(-1) then
        snip.jump(-1)
    end
end, { silent = true })

vim.keymap.set({ "i" }, "<C-l>", function ()
    if snip.choice_active() then
        snip.change_choice(1)
    end
end, { silent = true })
