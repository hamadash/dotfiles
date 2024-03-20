return {
  "nvim-telescope/telescope.nvim", tag = '0.1.6',
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { silent = true, noremap = true } },
  },
}
