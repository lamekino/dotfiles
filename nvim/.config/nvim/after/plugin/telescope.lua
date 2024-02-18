local ok, telescope = pcall(require, "telescope")
if not ok then return end

-- TODO: match this with bg = NONE
-- local hl_groups = {
--     "TelescopeNormal",
--     "TelescopeBorder",
--     "TelescopeSelectionCaret",
--     "TelescopeMatching",
--     "TelescopePromptNormal",
--     "TelescopePromptTitle",
--     "TelescopePromptPrefix",
--     "TelescopePromptBorder",
--     "TelescopePreviewTitle",
--     "TelescopePreviewBorder",
--     "TelescopeResultsTitle",
--     "TelescopeResultsBorder ",
-- }

telescope.setup {
    defaults = {
        layout_strategy = "horizontal",
    },
    pickers = {
        git_files = {
            hidden = true,
        },
        live_grep = {
            hidden = true,
        },
    },
}
