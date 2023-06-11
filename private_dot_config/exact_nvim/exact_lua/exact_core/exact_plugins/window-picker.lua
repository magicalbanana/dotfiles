return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  opts = {
    autoselect_one = true,
    include_current = false,
    hint = "statusline-winbar",
    selection_chars = "FJDKSLA;CMRUEIWOQP",
    filter_rules = {
      bo = {
        filetype = {
          "neo-tree",
          "neo-tree-popup",
          "notify",
          "packer",
          "qf",
          "diff",
          "fugitive",
          "fugitiveblame",
        },

        buftype = { "nofile", "help", "terminal" },
      },
    },
  },
}
