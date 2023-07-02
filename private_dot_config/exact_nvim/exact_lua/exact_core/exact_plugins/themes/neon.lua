M = {}

function M.setup()
  vim.g.neon_style = "doom"
  vim.g.neon_italic_keyword = true
  vim.g.neon_italic_function = true
  vim.g.neon_transparent = true

  local settings = require("core.settings")

  if settings.theme == "neon" then
    vim.cmd("colorscheme neon")
  end
end

return M
