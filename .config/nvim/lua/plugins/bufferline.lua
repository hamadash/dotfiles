local h = require("util.helper")

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    options = {
      numbers = "ordinal",
      show_close_icon = true,
    },
  },
  keys = {
    { "<C-q>", [["<CMD>bdelete<CR>"]], mode = "n", expr = true, replace_keycodes = false },
    { "<S-h>", [["<CMD>BufferLineCyclePrev<CR>"]], mode = "n", expr = true, replace_keycodes = false },
    { "<S-l>", [["<CMD>BufferLineCycleNext<CR>"]], mode = "n", expr = true, replace_keycodes = false },
    { "[t", [["<CMD>BufferLineMovePrev<CR>"]], mode = "n", expr = true, replace_keycodes = false },
    { "]t", [["<CMD>BufferLineMoveNext<CR>"]], mode = "n", expr = true, replace_keycodes = false },
    { "<Leader>bp", [["<CMD>BufferLinePick<CR>"]], mode = "n", expr = true, replace_keycodes = false },
    { "<Leader>bco", [["<CMD>BufferLineCloseOthers<CR>"]], mode = "n", expr = true, replace_keycodes = false },
  },
  lazy = false,
}
