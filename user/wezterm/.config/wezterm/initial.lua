function M(cfg, wt)
    local is_ms_windows = string.find(wt.target_triple, "windows", 0, true)

    -- environment
    cfg.default_prog = is_ms_windows and { "pwsh.exe", "-NoLogo" } or nil
    cfg.set_environment_variables = {} -- needs to be not nil for table.insert

    -- terminal settings
    cfg.audible_bell = "Disabled"
    cfg.exit_behavior = "Hold"
    cfg.exit_behavior_messaging = "Terse"
    cfg.enable_csi_u_key_encoding = true
    cfg.warn_about_missing_glyphs = false
    cfg.hyperlink_rules = wt.default_hyperlink_rules()
    cfg.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- disable lignatures
    cfg.automatically_reload_config = false
end

return M
