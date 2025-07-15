return {
	"hamadash/keymemo.nvim",
	-- dir = vim.fn.expand("~/development/keymemo.nvim"),
	event = "VeryLazy",
	keys = {
		{ "<leader>?", "<cmd>KeyMemo<cr>", desc = "Show keys memo" },
	},
	config = function()
		require("keymemo").setup({
			keys = {
				movement = {
					name = "移動",
					mappings = {
						["{"] = "前の段落へ移動",
						["}"] = "次の段落へ移動",
						["[["] = "前のセクションへ移動",
						["]]"] = "次のセクションへ移動",
						["<C-o>"] = "ジャンプ履歴を戻る",
					},
				},
				replace = {
					name = "置換",
					mappings = {
						[":%s/search/replace/g"] = "一括置換",
						[":%s/search/replace/gc"] = "確認しながら置換",
					},
				},
				edit = {
					name = "編集",
					mappings = {
						J = "行を連結（空白あり）",
						gJ = "行を連結（空白なし）",
						["<Block> + I"] = "矩形選択 → 行頭に文字追加",
						["<Block> + A"] = "矩形選択 → 行末に文字追加",
						["gUw"] = "単語の大文字変換",
						["vi)"] = "括弧内を選択",
						["va)"] = "括弧全体を選択",
						["vit"] = "タグ内を選択",
						["vat"] = "タグ全体を選択",
					},
				},
				fold = {
					name = "折りたたみ",
					mappings = {
						zf = "折りたたみ作成",
						zm = "すべて折りたたみ",
						zo = "展開",
						z0 = "再帰的に展開",
						zr = "少し展開",
						zR = "すべて展開",
					},
				},
				file = {
					name = "ファイル",
					mappings = {
						["<C-^>"] = "直前に開いていたファイルに戻る",
					},
				},
			},
		})
	end,
}
