local ok, telescope = pcall(require, "telescope")
if not ok then return end

telescope.setup {
    defaults = {
        layout_strategy = "horizontal",
    },
    pickers = {
        find_files = {
            theme = "ivy"
        },
        git_files = {
            hidden = true,
        },
        live_grep = {
            hidden = true,
        },
    },
}
