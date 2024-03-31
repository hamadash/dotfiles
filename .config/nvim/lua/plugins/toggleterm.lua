local h = require("util.helper")

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  init = function ()
    -- h.nmap("<M-,>", "<Cmd>BufferPrevious<CR>", { silent = true, noremap = true })
  end,
  opts = {
    size = 20,
  },
}
