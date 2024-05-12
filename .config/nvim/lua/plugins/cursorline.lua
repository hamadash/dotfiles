return {
  "yamatsum/nvim-cursorline",
  config = function()
    require('nvim-cursorline').setup {
      cursorword = {
        enable = true,
        min_length = 2,
        hl = { underline = true },
      }
    }
  end
}
