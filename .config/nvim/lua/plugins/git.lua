return {
  {
    "dinhhuy258/git.nvim",
    config = function()
      require('git').setup({
        default_mappings = true, -- NOTE: `quit_blame` and `blame_commit` are still merged to the keymaps even if `default_mappings = false`

        keymaps = {
          -- Open blame window
          blame = "<Leader>gb",
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
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<Leader>hp", "<CMD>Gitsigns preview_hunk<CR>",    mode = "n",          desc = "Show preview the hunk" },
      { "<Leader>hs", "<CMD>Gitsigns stage_hunk<CR>",      mode = { "n", "v" }, desc = "Stage the hunk" },
      { "<Leader>hu", "<CMD>Gitsigns undo_stage_hunk<CR>", mode = { "n", "v" }, desc = "Undo the last call of stage hunk" },
      { "<Leader>hr", "<CMD>Gitsigns reset_hunk<CR>",      mode = { "n", "v" }, desc = "Reset the lines of the hunk" },
      { "<Leader>hb", "<CMD>Gitsigns blame_line<CR>",      mode = { "n", "v" }, desc = "Blame line" },
    },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "*" },
          delete = { text = "-" },
          topdelete = { text = "-" },
          changedelete = { text = "*" },
        },
        preview_config = {
          border = "single",
          style = "minimal",
        },
      })
    end,
  },
  {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger",
    init = function()
      vim.g.git_messenger_floating_win_opts = { border = "single" }
    end,
    keys = {
      { "<C-k>", "<CMD>GitMessenger<CR>", mode = "n", desc = "Show git blame on the current line" },
    },
  },
}
