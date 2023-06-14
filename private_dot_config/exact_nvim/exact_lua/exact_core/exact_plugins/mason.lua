local settings = require("core.settings")
local utils = require("core.plugins.lsp.utils")

local M = {
  "williamboman/mason.nvim",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", module = "mason" },
  },
  config = function()
    require("mason").setup({
      install_root_dir = utils.get_asdf_shims_path(),
      PATH = "skip",
    })

    -- ensure tools (except LSPs) are installed
    local mr = require("mason-registry")
    for _, tool in ipairs(settings.tools) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end

    -- install LSPs
    require("mason-lspconfig").setup({ ensure_installed = settings.lsp_servers })
  end,
}

return M
