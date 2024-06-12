return {
  "akinsho/toggleterm.nvim",
  opts = {
    size = 20,
    direction = "float",
  },
  keys = {
    { "<C-t>", "<CMD>ToggleTerm<CR>", mode = "n" },
    { "<C-t>", "<CMD>ToggleTerm<CR>", mode = "t" },
  },
}
