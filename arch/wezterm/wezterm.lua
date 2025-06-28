local wezterm = require("wezterm")
local config = {}

config.color_scheme = "melange_dark"
config.window_background_opacity = 0.96
config.font = wezterm.font("0xProto Nerd Font Mono")
config.font_size = 13
config.enable_kitty_keyboard = true
config.debug_key_events = false

return config
