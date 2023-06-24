return {
  "toppair/peek.nvim",
  build = "deno task --quiet build:fast",
  config = function()
    require("peek").setup({
      autoload = false,
      close_on_bdelete = true,
      syntax = true,
      theme = "dark",
      update_on_change = true,
      app = { "chromium", "--new-window" },
      filetype = { "markdown" },
      throttle_at = 200000,
      throttle_time = "auto",
    })
  end
}
