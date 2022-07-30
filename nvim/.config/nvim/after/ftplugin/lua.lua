vim.keymap.set("n", "<F1>", ":luafile %<cr>")
vim.keymap.set("n", "<F2>", ":luafile $MYVIMRC<cr>")

vim.api.nvim_create_augroup("LuaAug", { clear = true })

-- TODO: make an autocmd which converts all single quotes to double quotes
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = "LuaAug",
--     desc = "convert single quotes to double quotes",
--     -- https://stackoverflow.com/a/2103764
--     command = [[:%s/"\([^"]*\)"/"\1"/g]]
-- })
