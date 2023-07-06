local M = {}

function M.setup()
  vim.g.nord_borders = false
  vim.g.nord_disable_background = false
  vim.g.nord_italic = false
  vim.g.nord_uniform_diff_background = true
  vim.g.nord_bold = false

  local settings = require("core.settings")

  if settings.theme == "nord" then
    vim.cmd("colorscheme nord")
  end
end

return M
