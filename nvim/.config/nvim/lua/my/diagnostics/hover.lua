vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function()
        if vim.fn.mode() ~= "i" then
            vim.diagnostic.open_float(nil, { focus = false })
        end
    end
})
