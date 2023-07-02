require("kanagawa").setup({
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  variablebuiltinStyle = { italic = true },
  specialReturn = true,    -- special highlight for the return keyword
  specialException = true, -- special highlight for exception handling keywords
  transparent = false,     -- do not set background color
  dimInactive = false,     -- dim inactive window `:h hl-NormalNC`
  globalStatus = true,     -- adjust window separators highlight for laststatus=3
  terminalColors = true,   -- define vim.g.terminal_color_{0,17}
  colors = {               -- add/modify theme and palette colors
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  overrides = function(colors) -- add/modify highlights
    return {}
  end,
  theme = "wave",  -- Load "wave" theme when 'background' option is not set
  background = {   -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus",
  },
})

local settings = require("core.settings")

if settings.theme == "kanagawa" then
  vim.cmd("colorscheme kanagawa")
end
