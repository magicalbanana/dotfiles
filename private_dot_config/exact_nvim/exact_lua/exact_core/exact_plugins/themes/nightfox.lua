require("nightfox").setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
  },
})

local settings = require("core.settings")

if settings.theme == "nightfox" then
  vim.cmd("colorscheme nightfox")
end
if settings.theme == "duskfox" then
  vim.cmd("colorscheme duskfox")
end
if settings.theme == "nordfox" then
  vim.cmd("colorscheme nordfox")
end
if settings.theme == "terafox" then
  vim.cmd("colorscheme terafox")
end
