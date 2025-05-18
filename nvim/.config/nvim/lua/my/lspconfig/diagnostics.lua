vim.diagnostic.config {
    virtual_text     = false,
    signs            = false,
    underline        = true,
    update_in_insert = false,
    severity_sort    = true,

    float            = {
        style         = "rounded",
        border        = require("my.aesthetic.square-border"),
        source        = "always",
        header        = "",
        prefix        = "",
        focusable     = true,
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
