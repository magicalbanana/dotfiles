return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "onsails/lspkind-nvim" },
    { "folke/neodev.nvim" },
    { "b0o/schemastore.nvim" },
  },
  config = function()
    require("neodev").setup()
    require("core.plugins.lsp.config")
  end,
}
