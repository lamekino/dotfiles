local okay, snip = pcall(require, "luasnip")

snip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true
}
