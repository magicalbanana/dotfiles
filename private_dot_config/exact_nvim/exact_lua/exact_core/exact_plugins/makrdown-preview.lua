return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown", "telekasten" },
  build = "cd app && npm install",
  config = function()
    vim.g.mkdp_filetypes = { "markdown", "telekasten" }
  end,
}
