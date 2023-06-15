return {
  "ggandor/leap.nvim",
  lazy = false,
  dependencies = {
    "ggandor/flit.nvim",
    dependencies = {
      "tpope/vim-repeat"
    }
  },
  config = function()
    require("leap").add_default_mappings()
  end,
}
