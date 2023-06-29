return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "onsails/lspkind-nvim" },
    { "b0o/schemastore.nvim" },
  },
  config = function()
    require("core.plugins.lsp.config")
  end,
}
