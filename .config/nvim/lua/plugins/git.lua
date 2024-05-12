local h = require("util.helper")

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
    init = function()
      h.nmap("<Leader>hp", "<CMD>Gitsigns preview_hunk<CR>", { desc = "Show preview the hunk" })

      for _, mode in pairs({ "n", "v" }) do
        local key = mode .. "map"
        h[key]("<Leader>hs", "<CMD>Gitsigns stage_hunk<CR>", { desc = "Stage the hunk" })
        h[key]("<Leader>hu", "<CMD>Gitsigns undo_stage_hunk<CR>", { desc = "Undo the last call of stage hunk" })
        h[key]("<Leader>hr", "<CMD>Gitsigns reset_hunk<CR>", { desc = "Reset the lines of the hunk" })
        h[key]("<Leader>hb", "<CMD>Gitsigns blame_line<CR>", { desc = "Blame line" })
      end
    end,
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
      h.nmap("<C-k>", "<CMD>GitMessenger<CR>", { desc = "Show git blame on the current line" })
      vim.g.git_messenger_floating_win_opts = { border = "single" }
    end,
  },
}
