local wezterm = require "wezterm"

local config = wezterm.config_builder()

config.enable_wayland = true

-- BINDS
require("binds").apply_to_config(config)

-- THEMEING
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false


return config
