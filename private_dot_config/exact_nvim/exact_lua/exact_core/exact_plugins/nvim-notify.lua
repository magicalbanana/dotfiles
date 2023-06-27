table.unpack = table.unpack or unpack -- 5.1 compatibility

return {
  "rcarriga/nvim-notify",
  config = function()
    local base_stages = require("notify.stages.slide")("bottom_up")
    local notify = require("notify")

    notify.setup({
      render = "compact",
      stages = {
        function(...)
          local opts = base_stages[1](...)
          if not opts then
            return
          end
          return opts
        end,
        table.unpack(base_stages, 2),
      },
      timeout = 1500,
      background_colour = "#121212",
      max_width = 120,
    })

    vim.notify = notify
  end,
}
