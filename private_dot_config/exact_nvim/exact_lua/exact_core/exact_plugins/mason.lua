local settings = require("core.settings")
-- local utils = require("core.plugins.lsp.utils")

return {
  "williamboman/mason.nvim",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", module = "mason" },
  },
  config = function()
    require("mason").setup({
      PATH = "prepend",
    })

    -- install LSPs
    require("mason-lspconfig").setup({ ensure_installed = settings.lsp_servers })
  end,
}
