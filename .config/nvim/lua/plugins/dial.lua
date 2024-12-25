return {
	"monaqa/dial.nvim",
	keys = {
		{
			"<C-a>",
			function()
				require("dial.map").manipulate("increment", "normal")
			end,
			mode = "n",
		},
		{
			"<C-x>",
			function()
				require("dial.map").manipulate("decrement", "normal")
			end,
			mode = "n",
		},
		-- NOTE: e.g. 5g<C-a>とすると、5ずつインクリメントできる。
		-- ただし、複数回実行する場合はドットリピートする。
		{
			"g<C-a>",
			function()
				require("dial.map").manipulate("increment", "gnormal")
			end,
			mode = "n",
		},
		{
			"g<C-x>",
			function()
				require("dial.map").manipulate("decrement", "gnormal")
			end,
			mode = "n",
		},
		{
			"<C-a>",
			function()
				require("dial.map").manipulate("increment", "visual")
			end,
			mode = "v",
		},
		{
			"<C-x>",
			function()
				require("dial.map").manipulate("decrement", "visual")
			end,
			mode = "v",
		},
		{
			"g<C-a>",
			function()
				require("dial.map").manipulate("increment", "gvisual")
			end,
			mode = "v",
		},
		{
			"g<C-x>",
			function()
				require("dial.map").manipulate("decrement", "gvisual")
			end,
			mode = "v",
		},
	},
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			-- default augends used when no group name is specified
			default = {
				augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
				augend.constant.alias.bool, -- boolean value (true <-> false)
				augend.constant.alias.ja_weekday, -- 月, 火, ..., 土, 日
				augend.constant.alias.ja_weekday_full, -- 月曜日, 火曜日, ..., 日曜日
				augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
				augend.date.alias["%Y-%m-%d"], -- date (2022-02-19, etc.)
				augend.date.alias["%Y年%-m月%-d日"], -- date (2022年02月19日, etc.)
				augend.constant.new({
					elements = { "&&", "||" },
					word = true,
					cyclic = true,
				}),
			},
		})
	end,
}
