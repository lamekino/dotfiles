local okay, neogit = pcall(require, "neogit")
if not okay then return end

neogit.setup {
    kind = "split",
    disable_signs = true,
    integrations = {
        diffview = true
    }
}
