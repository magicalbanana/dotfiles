return {
  "renerocksai/telekasten.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "iamcco/markdown-preview.nvim",
  },
  config = function()
    require("telekasten").setup({
      home = os.getenv("MEIN_WISSEN_PATH"), -- Put the name of your notes directory here
      take_over_my_home = false,
      auto_set_filetype = false,
      auto_set_syntax = true,
      install_syntax = true,
    })
  end,
}
