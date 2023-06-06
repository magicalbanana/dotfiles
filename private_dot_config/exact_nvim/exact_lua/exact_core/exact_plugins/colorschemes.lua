return {
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("core.plugins.themes.nightfox")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("core.plugins.themes.catppuccin")
    end,
  },
  {
    "folke/tokyonight.nvim",
    config = function()
      require("core.plugins.themes.tokyonight")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("core.plugins.themes.kanagawa")
    end,
  },
  {
    "sam4llis/nvim-tundra",
    config = function()
      require("core.plugins.themes.tundra")
    end,
  },
  {
    "shaunsingh/nord.nvim",
  },
  {
    "rmehri01/onenord.nvim",
    config = function()
      require("core.plugins.themes.onenord")
    end,
  },
}
