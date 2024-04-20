local h = require("util.helper")

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  init = function ()
    h.nmap("<C-q>", "<CMD>bdelete<CR>", { silent = true, noremap = true })
    h.nmap("<Leader>bp", "<CMD>BufferLinePick<CR>", { silent = true, noremap = true })
    h.nmap("<Leader>bco", "<CMD>BufferLineCloseOthers<CR>", { silent = true, noremap = true })
  end,
  opts = {
    numbers = "ordinal",
    show_close_icon = true,
  },
  config = function ()
    require('bufferline').setup({
      options = {
        numbers = "ordinal",
        show_close_icon = true,
      },
    })
  end,
}
