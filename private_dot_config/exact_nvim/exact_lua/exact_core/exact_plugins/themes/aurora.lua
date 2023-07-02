M = {}

function M.setup()
  vim.g.aurora_italic = 1
  vim.g.aurora_transparent = 0
  vim.g.aurora_bold = 1
  vim.g.aurora_darker = 1

  local settings = require("core.settings")

  if settings.theme == "aurora" then
    vim.cmd("colorscheme aurora")
  end
end

return M
