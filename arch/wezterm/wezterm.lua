local wezterm = require("wezterm")
local config = {}

config.color_scheme = "melange_dark"
config.window_background_opacity = 0.97
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", italic = false })
config.font_size = 14
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- disable ligatures
config.enable_kitty_keyboard = true
config.debug_key_events = false

return config
