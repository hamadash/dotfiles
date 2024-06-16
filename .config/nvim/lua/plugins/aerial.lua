return {
  "stevearc/aerial.nvim",
  opts = {
    layout = {
      min_width = 30,
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  -- FIXME: keys で設定したいが、エラーが出てしまう。
  init = function()
    vim.api.nvim_set_keymap('n', '<Leader>a', '<CMD>AerialToggle<CR>', { noremap = true, silent = true })
  end
}
