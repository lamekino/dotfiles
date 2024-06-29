local okay, jdtls = pcall(require, "jdtls")

if okay then
    local filter = { 'gradlew', '.git', 'mvnw' }
    local opts = { upward = true }

    jdtls.start_or_attach {
        cmd = { os.getenv("HOME") .. "/.local/bin/jdtls" },
        root_dir = vim.fs.dirname(vim.fs.find(filter, opts)[1]),
    }
end

vim.cmd [[compiler javag]]
vim.o.suffixesadd = ".java"
-- vim.o.makeprg = "mvn -q -f pom.xml test compile package"

vim.keymap.set("i", "<C-Space>", '<C-r>=expand("%:r")<cr>')

vim.api.nvim_buf_create_user_command(0, "JdtOrganizeImports", function()
    jdtls.organize_imports()
end, { ["bang"] = true })
