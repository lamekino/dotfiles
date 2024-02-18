vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    desc = "sets README files to have markdown filetype",
    pattern = "*README*",
    callback = function()
        vim.opt_local.filetype = "markdown"
    end
})
