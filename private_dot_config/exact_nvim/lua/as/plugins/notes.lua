if not as then return end
local mein_wissen_path = vim.g.mein_wissen_path
if as.falsy(mein_wissen_path) then return {} end

local fmt, ui = string.format, vim.ui
local highlight, border = as.highlight, as.ui.current.border
local function mein_wissen_dir(path) return fmt('%s/%s', mein_wissen_path, path) end

return {
  {
    'nvim-neorg/neorg',
    ft = 'norg',
    version = '*',
    dependencies = { 'luarocks.nvim' },
    opts = {
      configure_parsers = true,
      load = {
        ['core.defaults'] = {},
        ['core.completion'] = { config = { engine = 'nvim-cmp' } },
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = mein_wissen_dir('notes/'),
            },
          },
        },
      },
    },
  },
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
    'lukas-reineke/headlines.nvim',
    enabled = false,
    ft = { 'org', 'norg', 'markdown', 'yaml' },
    config = function()
      highlight.plugin('Headlines', {
        theme = {
          ['*'] = {
            { Dash = { bg = '#0B60A1', bold = true } },
          },
          ['horizon'] = {
            { Headline = { bold = true, italic = true, bg = { from = 'Normal', alter = 0.2 } } },
            { Headline1 = { inherit = 'Headline', fg = { from = 'Type' } } },
          },
        },
      })
      require('headlines').setup({
        org = { headline_highlights = false },
        norg = { headline_highlights = { 'Headline' }, codeblock_highlight = false },
        markdown = { headline_highlights = { 'Headline1' } },
      })
    end,
  },
}
