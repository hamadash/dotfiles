return {
  "APZelos/blamer.nvim",
  init = function ()
    vim.g.blamer_enabled = true
    vim.g.blamer_delay = 500
    vim.g.blamer_date_format = "%Y/%m/%d %H:%M"
  end
}
