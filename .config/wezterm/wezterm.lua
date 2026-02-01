-- see: https://wezfurlong.org/wezterm/config/files.html#configuration-overrides

local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.leader = { key = "h", mods = "CTRL", timeout_milliseconds = 1000 }

config.window_close_confirmation = "AlwaysPrompt" -- TODO: 効いていない?

-- keybinds
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.disable_default_key_bindings = true

require("appearance").apply_to_config(config)

-- workspace
local workspace = require("workspace")
for _, key in ipairs(workspace.keys) do
	table.insert(config.keys, key)
end

return config
