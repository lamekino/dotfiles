local okay, presence = pcall(require, "presence")
if not okay then return end

presence.setup {
    -- General options
    auto_update         = true,                           -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "The One True Text Editor",     -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",                       -- Main image display (either "neovim" or "file")
    client_id           = "793271441293967371",           -- Use your own Discord application client id (not recommended)
    log_level           = nil,                            -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                             -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                          -- Displays the current line number instead of the current project
    -- TODO: this doesn't work how i want it to..
    blacklist           = {
        "^(?!" .. os.getenv("HOME") .. "/src/)"
    },
    buttons             = true,     -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {},       -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,     -- Show the timer

    -- Rich Presence text options
    -- TODO: restore this after figuring out blacklist
    editing_text        = "  ",
    file_explorer_text  = "  ",
    git_commit_text     = "  ",
    plugin_manager_text = "  ",
    reading_text        = "  ",
    workspace_text      = "  ",
    line_number_text    = "  ",
}
