vim.diagnostic.config {
    virtual_text     = false,
    signs            = true,
    underline        = false,
    update_in_insert = false,
    severity_sort    = true,

    float            = {
        style         = "rounded",
        border        = require("user.aesthetics.square_border"),
        source        = "always",
        header        = "",
        prefix        = "",
        focusable     = false,
        severity_sort = true
    },
}

-- create the autocmd for opening diagnostic windows
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function()
        if vim.fn.mode() ~= "i" then
            vim.diagnostic.open_float(nil, { focus = false })
        end
    end
})
