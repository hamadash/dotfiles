return {
  "is0n/fm-nvim",
  keys = {
    { '<Space>g', ':Lazygit<CR>' },
  },
  config = function()
    require('fm-nvim').setup {
      ui = {
        float = {
          height = 1.0,
          weight = 1.0,
        }
      }
    }
  end
}
