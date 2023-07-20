local okay, todo = pcall(require, "todo-comments")
if not okay then return end

todo.setup {
    signs = false,
    highlight = {
        before = "",
        keyword = "fg",
        after = "fg",
    }
}
