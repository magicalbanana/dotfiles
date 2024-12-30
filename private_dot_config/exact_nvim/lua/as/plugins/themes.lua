return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'tiagovla/tokyodark.nvim',
    lazy = false,
    opts = {
      gamma = 0.75,
    },
    config = function(_, opts)
      require('tokyodark').setup(opts) -- calling setup is optional
    end,
  },
}
