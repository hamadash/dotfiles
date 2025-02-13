return {
	"dinhhuy258/git.nvim",
	config = function()
		require("git").setup({
			default_mappings = false,

			keymaps = {
				-- Close blame window
				quit_blame = "q",
				-- Open blame commit
				blame_commit = "<CR>",
				-- Open file/folder in git repository
				browse = "<Leader>go",
				-- Open pull request of the current branch
				open_pull_request = "<Leader>gp",
				-- Opens a new diff that compares against the current index
				diff = "<Leader>gd",
				-- Close git diff
				diff_close = "<Leader>gD",
				-- Revert to the specific commit
				revert = "<Leader>gr",
				-- Revert the current file to the specific commit
				revert_file = "<Leader>gR",
			},
		})
	end,
}
