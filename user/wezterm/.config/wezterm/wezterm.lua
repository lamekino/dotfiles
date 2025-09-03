local wt = require("wezterm")

local my_cfg = {}

for _, mod in ipairs({
    "initial", "events", "keyboard", "mouse", "ui", "theme", "fonts"
}) do
    require(mod)(my_cfg, wt)
end

return my_cfg
