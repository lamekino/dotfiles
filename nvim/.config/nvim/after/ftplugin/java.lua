vim.cmd [[compiler javag]]
vim.o.suffixesadd = ".java"
vim.o.makeprg = "mvn -q -f pom.xml test compile package"

vim.keymap.set("i", "<C-Space>", '<C-r>=expand("%:r")<cr>')
