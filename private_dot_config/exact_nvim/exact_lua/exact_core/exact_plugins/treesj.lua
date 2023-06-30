return {
  "Wansmer/treesj",
  keys = {
    "<space><space>m",
    "<space><space>j",
    "<space><space>s",
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("treesj").setup({
      use_default_keymaps = false,
    })
  end,
}
