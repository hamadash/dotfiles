return {
  "kinsho/toggleterm.nvim",
  opts = {
    size = 20,
  },
  keys = {
    { "<C-t>", [["<CMD>ToggleTerm<CR>"]], mode = "n", expr = true, replace_keycodes = false },
    { "<C-t>", [["<C-\\><C-n><Cmd>ToggleTerm<CR>"]], mode = "t", expr = true, replace_keycodes = false },
  },
}
