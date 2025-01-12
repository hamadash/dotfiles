-- see: https://wezfurlong.org/wezterm/config/files.html#configuration-overrides

local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 14.0
config.window_background_opacity = 0.80
-- TODO: 効いていない?
config.window_close_confirmation = "AlwaysPrompt"
config.window_decorations = "RESIZE"

-- 起動時のウィンドウサイズ TODO: window:maximize() が使える？
config.initial_rows = 50
config.initial_cols = 180

-- keybinds
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.disable_default_key_bindings = true

config.leader = { key = "h", mods = "CTRL", timeout_milliseconds = 1000 }

return config
