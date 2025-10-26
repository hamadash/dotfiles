-- see: https://wezfurlong.org/wezterm/config/files.html#configuration-overrides

local wezterm = require("wezterm")

local config = wezterm.config_builder()

----------------------------
-- 見た目設定
----------------------------
config.color_scheme = "Tokyo Night"
config.font_size = 14.0

-- 透過
config.window_background_opacity = 0.80

-- ぼかし具合
config.macos_window_background_blur = 8

-- タイトルバーを非表示
config.window_decorations = "RESIZE"

-- タブバーの色を背景と同じにする
config.window_background_gradient = {
	colors = { "#000000" },
}

-- タブバーの + ボタンを削除
config.show_new_tab_button_in_tab_bar = false

-- タブバーの x ボタンを削除 ※ nightly 版だけ
-- config.show_close_tab_button_in_tabs = false

-- タブタイトルのフォーマット
-- see: https://wezterm.org/config/lua/window-events/format-tab-title.html
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"

	if tab.is_active then
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = tab.active_pane.title },
	}
end)

-- 起動時のウィンドウサイズ TODO: window:maximize() が使える？
config.initial_rows = 50
config.initial_cols = 180

----------------------------
-- ユーティリティ設定
----------------------------
config.leader = { key = "h", mods = "CTRL", timeout_milliseconds = 1000 }

config.window_close_confirmation = "AlwaysPrompt" -- TODO: 効いていない?

-- keybinds
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.disable_default_key_bindings = true

return config
