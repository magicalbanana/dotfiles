local utils = require("core.utils.functions")

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    require("core.plugins.alpha.alpha")
  end,
  cond = utils.firenvim_not_active(),
}
