return {
  "ten3roberts/window-picker.nvim",
  opts = {
    -- Default keys to annotate, keys will be used in order. The default uses the
    -- most accessible keys from the home row and then top row.
    keys = "alskdjfhgwoeiruty",
    -- Swap windows by holding shift + letter
    swap_shift = true,
    -- Windows containing filetype to exclude
    exclude = {
      qf = true,
      NvimTree = true,
      aerial = true,
      Neotree = true,
    },
    -- Flash the cursor line of the newly focused window for 300ms.
    -- Set to 0 or false to disable.
    flash_duration = 300,
  },
  keys = {
    { "<leader>ww", "<cmd>WindowPick<cr>", desc = "Pick window" },
    { "<leader>ws", "<cmd>WindowSwap<cr>", desc = "Swap window" },
    { "<leader>wq", "<cmd>WindowZap<cr>", desc = "Zap window" },
  },
}
