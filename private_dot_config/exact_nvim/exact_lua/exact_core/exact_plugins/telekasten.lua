return {
  "renerocksai/telekasten.nvim",
  dependencies = {
    "nvim-telescope/telescope-symbols.nvim",
    "iamcco/markdown-preview.nvim",
  },
  config = function()
    require("telekasten").setup({
      home = os.getenv("MEIN_WISSEN_PATH"), -- Put the name of your notes directory here
    })
  end
}
