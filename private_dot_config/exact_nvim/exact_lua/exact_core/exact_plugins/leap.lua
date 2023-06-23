return {
  "ggandor/leap.nvim",
  lazy = false,
  dependencies = {
    {
      "ggandor/flit.nvim",
      config = function()
        require("flit").setup()
      end,
      dependencies = {
        "tpope/vim-repeat"
      },
    }

  },
  config = function()
    require("leap").add_default_mappings()
  end,
}
