local wt = require("wezterm")

local is_windows = string.find(wt.target_triple, "windows")
local modules = { "window", "fonts", "action", "theme" }

local cfg = {
    default_prog = is_windows and { "pwsh.exe", "-NoLogo" } or nil,
    set_environment_variables = {},
    audible_bell = "Disabled",
    enable_csi_u_key_encoding = true,
    warn_about_missing_glyphs = false,
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- disable lignatures
}

for _, mod in ipairs(modules) do
    require(mod)(cfg, wt)
end

return cfg
