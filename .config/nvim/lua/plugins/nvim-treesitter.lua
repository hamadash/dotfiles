return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "UIEnter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-endwise",
    "windwp/nvim-ts-autotag"
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      auto_install = false,
      ensure_installed = "all",
      endwise = { enable = true },
      autotag = { enable = true },
    })
  end,
}
