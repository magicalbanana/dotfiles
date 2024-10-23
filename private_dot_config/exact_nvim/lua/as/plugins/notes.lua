local mein_wissen_path = vim.g.mein_wissen_path
if as.falsy(mein_wissen_path) then return {} end

local fmt = string.format
local highlight = as.highlight
local function mein_wissen_dir(path) return fmt('%s/%s', mein_wissen_path, path) end

return {
  {
    'renerocksai/telekasten.nvim',
    lazy = false,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-telescope/telescope-symbols.nvim',
      'iamcco/markdown-preview.nvim',
      'renerocksai/calendar-vim',
    },
    config = function()
      require('telekasten').setup({
        -- Main paths
        home = mein_wissen_dir('notes'),
        dailies = mein_wissen_dir('notes/daily'),
        weeklies = mein_wissen_dir('notes/weekly'),
        templates = mein_wissen_dir('notes/templates'),

        template_new_note = mein_wissen_dir('notes/templates/new_note_tk.md'),
        template_new_daily = mein_wissen_dir('notes/templates/daily_tk.md'),
        template_new_weekly = mein_wissen_dir('notes/templates/weekly_tk.md'),

        -- Generate note filenames. One of:
        -- "title" (default) - Use title if supplied, uuid otherwise
        -- "uuid" - Use uuid
        -- "uuid-title" - Prefix title by uuid
        -- "title-uuid" - Suffix title with uuid
        new_note_filename = 'uuid-title',
        filename_space_subst = '_',
        new_note_location = 'smart',
        -- file uuid type ("rand" or input for os.date such as "%Y%m%d%H%M")
        uuid_type = os.time(os.date('!*t')),
        -- UUID separator
        uuid_sep = '_',

        image_subdir = 'images',
        image_link_style = 'markdown',
        take_over_my_home = false,
        auto_set_filetype = false,
        auto_set_syntax = true,
        install_syntax = true,
      })

      -- Launch panel if nothing is typed after <leader>z
      map('n', '<leader>z', '<cmd>Telekasten panel<CR>')

      -- Most used functions
      map('n', '<leader>zf', '<cmd>Telekasten find_notes<CR>')
      map('n', '<leader>zg', '<cmd>Telekasten search_notes<CR>')
      map('n', '<leader>zd', '<cmd>Telekasten goto_today<CR>')
      map('n', '<leader>zz', '<cmd>Telekasten follow_link<CR>')
      map('n', '<leader>zn', '<cmd>Telekasten new_note<CR>')
      map('n', '<leader>zc', '<cmd>Telekasten show_calendar<CR>')
      map('n', '<leader>zb', '<cmd>Telekasten show_backlinks<CR>')
      map('n', '<leader>zI', '<cmd>Telekasten insert_img_link<CR>')

      -- Call insert link automatically when we start typing a link
      map('i', '[[', '<cmd>Telekasten insert_link<CR>')
    end,
  },
  {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    ft = "norg",
    version = "*", -- Pin Neorg to the latest stable release
    config = true,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    lazy = false,
    enabled = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
  },
}
