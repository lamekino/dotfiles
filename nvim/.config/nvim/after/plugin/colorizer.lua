local okay, colorizer = pcall(require, "colorizer")
if not okay then return end

colorizer.setup(nil, {
    '*',
    names = false,
})
