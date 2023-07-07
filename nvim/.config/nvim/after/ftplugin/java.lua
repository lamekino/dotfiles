vim.cmd [[compiler javag]]
vim.o.suffixesadd = ".java"
vim.o.makeprg = "mvn -q -f pom.xml test compile package"

vim.keymap.set("n", "<C-s>", '<C-r>=expand("%:r")<cr>')
vim.keymap.set("n", "<F2>", ':!java <C-r>=expand("%:r")<cr><cr>')
vim.keymap.set("n", "<F3>", ':!find-junit <C-r>=expand("%:r")<cr><cr>')
vim.keymap.set("n", "<F12>", ":!rm *.class<cr>")

-- I want to make this better...
vim.keymap.set("n", "<Leader>p", "oSystem.out.println();<Esc>F(")
vim.keymap.set("n", "<Leader>P", "oSystem.err.println();<Esc>F(")
