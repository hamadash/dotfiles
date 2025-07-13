return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
  -- stylua: ignore
  keys = {
    -- r の便利な利用方法
    -- https://minerva.mamansoft.net/2024-03-27-underrated-essential-neovim-plugins#:~:text=%E7%B4%B9%E4%BB%8B%E3%81%97%E3%81%BE%E3%81%99%E3%80%82-,Remote%20Actions,-%E7%8F%BE%E5%9C%A8%E3%81%AE%E3%82%AB%E3%83%BC%E3%82%BD%E3%83%AB
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "<Leader>hh", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  },
}
