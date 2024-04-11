local h = require("util.helper")

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
  init = function ()
    h.nmap("<Leader>a", "<CMD>AerialToggle!<CR>")
  end
}
