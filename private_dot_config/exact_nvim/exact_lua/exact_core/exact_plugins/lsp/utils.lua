local utils = require("core.utils.functions")

M = {}

-- TODO: refactor
-- must be global or the initial state is not working
VIRTUAL_TEXT_ACTIVE = true
-- toggle displaying virtual text
M.toggle_virtual_text = function()
  VIRTUAL_TEXT_ACTIVE = not VIRTUAL_TEXT_ACTIVE
  utils.notify(
    string.format("Virtualtext %s", VIRTUAL_TEXT_ACTIVE and "on" or "off"),
    vim.log.levels.INFO,
    "lsp/utils.lua"
  )
  vim.diagnostic.show(nil, 0, nil, { virtual_text = VIRTUAL_TEXT_ACTIVE })
end

-- TODO: refactor
-- must be global or the initial state is not working
AUTOFORMAT_ACTIVE = true
-- toggle null-ls's autoformatting
M.toggle_autoformat = function()
  AUTOFORMAT_ACTIVE = not AUTOFORMAT_ACTIVE
  utils.notify(
    string.format("Autoformatting %s", AUTOFORMAT_ACTIVE and "on" or "off"),
    vim.log.levels.INFO,
    "lsp.utils"
  )
end

-- detect python venv
-- https://github.com/neovim/nvim-lspconfig/issues/500#issuecomment-851247107
M.get_python_path = function(workspace)
  local lsp_util = require("lspconfig/util")
  local path = lsp_util.path
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end
  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end
  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

M.get_asdf_shims_path = function()
  local lsp_util = require("lspconfig/util")
  local path = lsp_util.path

  return path.join(vim.env.ASDF_DIR, "shims")
end

JDLS_PATH = utils.capture_cmd([[brew info jdtls | grep "/opt/homebrew/Cellar/" | awk '{print $1}']])

M.get_jdtls_path = function()
  if utils.is_empty(JDLS_PATH) then
    JDLS_PATH = utils.capture_cmd([[brew info jdtls | grep "/opt/homebrew/Cellar/" | awk '{print $1}']])
  end
  return JDLS_PATH
end

return M
