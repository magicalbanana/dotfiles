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
    config = function()
      require("core.plugins.themes.nord").setup()
    end,
  },
  {
    "rmehri01/onenord.nvim",
    config = function()
      require("core.plugins.themes.onenord")
    end,
  },
  {
    "AlexvZyl/nordic.nvim",
    config = function()
      require("nordic").load()
    end,
  },
  {
    "rafamadriz/neon",
    init = function()
      require("core.plugins.themes.neon").setup()
    end,
  },
  {
    "ray-x/aurora",
    init = function()
      require("core.plugins.themes.aurora").setup()
    end,
  },
  {
    "NTBBloodbath/doom-one.nvim",
    init = function()
      require("core.plugins.themes.doomone").setup()
    end,
  },
  {
    "marko-cerovac/material.nvim",
    init = function()
      require("core.plugins.themes.material")
    end,
  },
  {
    "navarasu/onedark.nvim",
    init = function()
      require("core.plugins.themes.onedark")
    end,
  },
}
