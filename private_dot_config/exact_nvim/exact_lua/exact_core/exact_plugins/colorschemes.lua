return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("core.plugins.themes.tokyonight")

      vim.cmd([[colorscheme tokyonight-storm]])
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
    "marko-cerovac/material.nvim",
    config = function()
      require("core.plugins.themes.material")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("core.plugins.themes.nightfox")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("core.plugins.themes.kanagawa")
    end,
  },
  {
    "rmehri01/onenord.nvim",
    config = function()
      require("core.plugins.themes.tokyonight")
    end,
  },
  {
    "shaunsingh/nord.nvim",
    config = function()
      require("core.plugins.themes.nord").setup()
    end,
  },
}
