return {
  "akinsho/toggleterm.nvim",
  opts = {
    size = 20,
    direction = "float",
  },
  keys = {
    { "<C-t>", [["<CMD>ToggleTerm<CR>"]], mode = "n", expr = true, replace_keycodes = false },
    { "<C-t>", [["<CMD>ToggleTerm<CR>"]], mode = "t", expr = true, replace_keycodes = false },
  },
}
