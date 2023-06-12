return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "onsails/lspkind-nvim" },
    { "folke/neodev.nvim", config = true },
    { "b0o/schemastore.nvim" },
  },
  config = function()
    require("core.plugins.lsp.config")
  end,
}
