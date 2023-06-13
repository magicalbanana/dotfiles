local settings = require("core.settings")
local lspconfig = require("lspconfig")
local utils = require("core.plugins.lsp.utils")
local servers = require("core.plugins.lsp.servers")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autoclompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("core.utils.functions").on_attach(function(client, buffer)
  -- disable formatting for LSP clients as this is handled by null-ls
  -- TODO: not required anymore?
  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false
  require("core.plugins.lsp.keys").on_attach(client, buffer)
end)

local common_config = {
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
}

for _, lsp in ipairs(settings.lsp_servers) do
  if lsp == "rust_analyzer" then
    vim.notify("rust_analyzer is managed by rust-tools", vim.log.levels.INFO, { title = "LSP config" })
    goto continue
  end

  if lsp == "gopls" then
    vim.notify("gopls is managed by go-nvim", vim.log.levels.INFO, { title = "LSP config" })
    goto continue
  end

  local server_config = servers[lsp] or {}

  lspconfig[lsp].setup({
    vim.tbl_deep_extend("keep", common_config, server_config),
  })
  ::continue::
end
