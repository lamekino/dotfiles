vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { ".s", ".asm" },
    callback = function()
        vim.bo.filetype = "asm"
    end
})
