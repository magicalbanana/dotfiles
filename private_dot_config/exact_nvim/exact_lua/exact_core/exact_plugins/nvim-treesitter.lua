return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-endwise",
    "mfussenegger/nvim-ts-hint-textobject",
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/playground",
    "HiPhish/nvim-ts-rainbow2",
  },
  config = function()
    local settings = require("core.settings")
    local rainbow = require("ts-rainbow")

    require("nvim-treesitter.configs").setup({
      ensure_installed = settings.treesitter_ensure_installed,
      ignore_install = {}, -- List of parsers to ignore installing
      rainbow = {
        enable = true,
        query = "rainbow-parens",
        strategy = rainbow.strategy.global,
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = {},  -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          scope_incremental = "<CR>",
          node_incremental = "<TAB>",
          node_decremental = "<S-TAB>",
        },
      },
      endwise = {
        enable = true,
      },
      indent = { enable = true },
      autopairs = { enable = true },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["of"] = "@function.outer",
            ["if"] = "@function.inner",
            ["oc"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ol"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ib"] = "@block.inner",
            ["ob"] = "@block.outer",
            ["ip"] = "@parameter.inner",
            ["op"] = "@parameter.outer",
          },
        },
      },
    })

    require("nvim-ts-autotag").setup()
  end,
}
