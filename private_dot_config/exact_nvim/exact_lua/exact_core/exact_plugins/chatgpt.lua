local key = os.getenv("OPENAI_API_KEY")
if key == nil or key == "" then
  return {}
end

local utils = require("core.utils.functions")

return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup()
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cond = utils.firenvim_not_active(),
}
