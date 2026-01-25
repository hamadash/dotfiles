return {
	"hamadash/keymemo.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>?", "<cmd>KeyMemo<cr>", desc = "Show keys memo" },
	},
	config = function()
		require("keymemo").setup({
			keys = {
				{
					name = "移動",
					mappings = {
						{ key = "{", desc = "前の段落へ移動" },
						{ key = "}", desc = "次の段落へ移動" },
						{ key = "[[", desc = "前のセクションへ移動" },
						{ key = "]]", desc = "次のセクションへ移動" },
						{ key = "<C-o>", desc = "ジャンプ履歴を戻る" },
					},
				},
				{
					name = "置換",
					mappings = {
						{ key = ":%s/search/replace/g", desc = "一括置換" },
						{ key = ":%s/search/replace/gc", desc = "確認しながら置換" },
					},
				},
				{
					name = "編集",
					mappings = {
						{ key = "J", desc = "行を連結(空白あり)" },
						{ key = "gJ", desc = "行を連結(空白なし)" },
						{ key = "<Block> + I", desc = "矩形選択 → 行頭に文字追加" },
						{ key = "<Block> + A", desc = "矩形選択 → 行末に文字追加" },
						{ key = "gUw", desc = "単語の大文字変換" },
						{ key = "va)", desc = "括弧全体を選択" },
						{ key = "vit", desc = "タグ内を選択" },
						{ key = "vat", desc = "タグ全体を選択" },
						{ key = 'vt"', desc = '現在位置から"までを選択' },
						{ key = "d0", desc = "カーソル位置から行頭までを削除" },
						{ key = "<C-u>", desc = "insert モードで行頭までを削除" },
					},
				},
				{
					name = "折りたたみ",
					mappings = {
						{ key = "zf", desc = "折りたたみ作成" },
						{ key = "zm", desc = "すべて折りたたみ" },
						{ key = "zo", desc = "展開" },
						{ key = "z0", desc = "再帰的に展開" },
						{ key = "zr", desc = "少し展開" },
						{ key = "zR", desc = "すべて展開" },
					},
				},
				{
					name = "ファイル",
					mappings = {
						{ key = "<C-^>", desc = "直前に開いていたファイルに戻る" },
					},
				},
			},
		})
	end,
}
