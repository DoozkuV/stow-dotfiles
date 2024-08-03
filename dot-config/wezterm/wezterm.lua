local wezterm = require "wezterm"

local config = wezterm.config_builder()

config.enable_wayland = true

-- BINDS
require("binds").apply_to_config(config)

-- THEMEING
config.color_scheme = 'Catppuccin Mocha'

-- Enable transparency except with KDE.
if not os.getenv("KDE_FULL_SESSION") then
    config.window_background_opacity = 0.0
end

config.window_padding = {
    left = 1,
    right = 1,
    top = 0,
    bottom = 0,
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false


return config
