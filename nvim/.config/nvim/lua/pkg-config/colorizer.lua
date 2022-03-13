-- https://github.com/norcalli/nvim-colorizer.lua
local okay, colorizer  = pcall(require, "colorizer")
if not okay then
    return
end

colorizer.setup {
    "*";
    css = { rgb_fn = true; };
}
