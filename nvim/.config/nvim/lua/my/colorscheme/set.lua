local M = {}

M.tweak = function(group_name, tweaks)
    local hl = vim.api.nvim_get_hl(0, { name = group_name })

    for field, tweak in pairs(tweaks) do
        hl[field] = tweak
    end

    vim.api.nvim_set_hl(0, group_name, hl)
end

M.groups = function(group_names, new_colors)
    for _, group in ipairs(group_names) do
        M.tweak(group, new_colors)
    end
end

M.link = function(group_names, link_name)
    M.groups(group_names, { link = link_name })
end

return M
