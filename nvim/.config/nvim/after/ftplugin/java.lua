vim.cmd [[compiler javag]]
vim.o.suffixesadd = ".java"
vim.o.makeprg = "mvn -q -f pom.xml test compile package"

local okay, jdtls = pcall(require, "jdtls")
if not okay then return end

vim.api.nvim_buf_create_user_command(
    0,
    "JdtOrganizeImports",
    jdtls.organize_imports,
    { ["bang"] = true }
)
