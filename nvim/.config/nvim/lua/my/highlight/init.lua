local M = {}

M.set_tweak = function(group_name, tweaks)
    local hl = vim.api.nvim_get_hl(0, { name = group_name })

    for field, tweak in pairs(tweaks) do
        hl[field] = tweak
    end

    vim.api.nvim_set_hl(0, group_name, hl)
end

M.set_groups = function(group_names, new_colors)
    for _, group in ipairs(group_names) do
        M.set_tweak(group, new_colors)
    end
end

return M
