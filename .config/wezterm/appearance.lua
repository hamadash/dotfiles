local wezterm = require("wezterm")
local module = {}

local appearance = {
	color_scheme = "Tokyo Night",
	font_size = 14.0,

	-- 透過
	window_background_opacity = 0.80,

	-- ぼかし具合
	macos_window_background_blur = 8,

	-- タイトルバーを非表示
	window_decorations = "RESIZE",

	-- 現在の workspace 名を表示
	wezterm.on("update-right-status", function(window, pane)
		local active_workspace_name = window:active_workspace()
		local date = wezterm.strftime("%Y/%m/%d %H:%M:%S")

		window:set_right_status(wezterm.format({
			-- 後ろに半角スペース2個程度空けておかないと右端に詰まって表示される
			{ Text = "workspace: " .. active_workspace_name .. " : " .. date .. "  " },
		}))
	end),

	-- タブバーの色を背景と同じにする
	window_background_gradient = {
		colors = { "#000000" },
	},

	-- タブバーの + ボタンを削除
	show_new_tab_button_in_tab_bar = false,

	-- タブバーの x ボタンを削除 ※ nightly 版だけ
	-- show_close_tab_button_in_tabs = false

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
	end),

	-- カーソルの点滅を無効化
	cursor_blink_rate = 0,
}

function module.apply_to_config(config)
	for k, v in pairs(appearance) do
		config[k] = v
	end
end

return module
