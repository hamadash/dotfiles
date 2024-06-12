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
    { "<C-q>",       "<CMD>bdelete<CR>",               mode = "n", remap = false },
    { "<S-h>",       "<CMD>BufferLineCyclePrev<CR>",   mode = "n" },
    { "<S-l>",       "<CMD>BufferLineCycleNext<CR>",   mode = "n" },
    { "[t",          "<CMD>BufferLineMovePrev<CR>",    mode = "n" },
    { "]t",          "<CMD>BufferLineMoveNext<CR>",    mode = "n" },
    { "<Leader>bp",  "<CMD>BufferLinePick<CR>",        mode = "n" },
    { "<Leader>bco", "<CMD>BufferLineCloseOthers<CR>", mode = "n" },
  },
  lazy = false,
}
