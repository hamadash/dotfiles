return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lspsaga").setup({
      symbol_in_winbar = {
        enable = true,
      },
      code_action = {
        extend_gitsigns = true,
      },
      lightbulb = {
        enable = false,
      },
    })
  end,
  keys = {
    { mode = "n", "<Leader>lca", "<CMD>Lspsaga code_action<CR>",           desc = "lspsaga code_action" },
    { mode = "n", "<Leader>lgd", "<CMD>Lspsaga goto_definition<CR>",       desc = "lspsaga goto_definition" },
    { mode = "n", "<Leader>lpd", "<CMD>Lspsaga peek_definition<CR>",       desc = "lspsaga peek_definition" },
    { mode = "n", "<Leader>lsd", "<CMD>Lspsaga show_line_diagnostics<CR>", desc = "lspsaga show_line_diagnostics" },
    { mode = "n", "<Leader>[l",  "<CMD>Lspsaga diagnostic_jump_prev<CR>",  desc = "lspsaga diagnostic_jump_prev" },
    { mode = "n", "<Leaaer>]l",  "<CMD>Lspsaga diagnostic_jump_next<CR>",  desc = "lspsaga diagnostic_jump_next" },
    { mode = "n", "<Leader>lf",  "<CMD>Lspsaga finder<CR>",                desc = "lspsaga finder" },
    { mode = "n", "<Leader>lto", "<CMD>Lspsaga open_floaterm<CR>",         desc = "lspsaga open float terminal" },
    { mode = "n", "<Leader>ltc", "<CMD>Lspsaga close_floaterm<CR>",        desc = "lspsaga close float terminal" },
    { mode = "n", "<Leader>lh",  "<CMD>Lspsaga hover_doc<CR>",             desc = "lspsaga documentation" },
    { mode = "n", "<Leader>lr",  "<CMD>Lspsaga rename<CR>",                desc = "lspsaga rename" },
  },
}
