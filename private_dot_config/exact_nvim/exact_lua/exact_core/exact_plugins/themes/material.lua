require("material").setup({
  contrast = {
    terminal = false, -- Enable contrast for the built-in terminal
    sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
    floating_windows = false, -- Enable contrast for floating windows
    cursor_line = false, -- Enable darker background for the cursor line
    non_current_windows = false, -- Enable contrasted background for non-current windows
    filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
  },
  plugins = { -- Uncomment the plugins that you use to highlight them
    "dap",
    "gitsigns",
    "indent-blankline",
    "neogit",
    "nvim-cmp",
    "nvim-navic",
    "nvim-tree",
    "nvim-web-devicons",
    "telescope",
    "trouble",
    "which-key",
  },
})
