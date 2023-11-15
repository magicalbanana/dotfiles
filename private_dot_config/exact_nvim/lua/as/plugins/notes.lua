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
    build = ':Neorg mein_wissen_dir-parsers',
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
    'nvim-orgmode/orgmode',
    keys = { '<leader>oa', '<leader>oc' },
    dependencies = {
      {
        'akinsho/org-bullets.nvim',
        dev = true,
        opts = { symbols = { checkboxes = { todo = { '⛌', 'OrgTODO' } } } },
      },
    },
    opts = {
      ui = {
        menu = {
          handler = function(data)
            local items = vim.tbl_filter(
              function(i) return i.key and i.label:lower() ~= 'quit' end,
              data.items
            )
            ui.select(items, {
              prompt = fmt(' %s ', data.prompt),
              kind = 'orgmode',
              format_item = function(item) return fmt('%s → %s', item.key, item.label) end,
            }, function(choice)
              if not choice then return end
              if choice.action then choice.action() end
            end)
          end,
        },
      },
      org_agenda_files = { mein_wissen_dir('orgfiles/**/*') },
      org_default_notes_file = mein_wissen_dir('orgfiles/notes.org'),
      org_todo_keywords = { 'TODO(t)', 'WAITING', 'IN-PROGRESS', '|', 'DONE(d)', 'CANCELLED' },
      org_todo_keyword_faces = {
        ['IN-PROGRESS'] = ':foreground royalblue :weight bold',
        ['CANCELLED'] = ':foreground darkred :weight bold',
      },
      org_hide_emphasis_markers = true,
      org_hide_leading_stars = true,
      org_agenda_skip_scheduled_if_done = true,
      org_agenda_skip_deadline_if_done = true,
      org_capture_templates = {
        t = {
          description = 'Task',
          template = '* TODO %?\n %u',
          target = mein_wissen_dir('orgfiles/todo.org'),
        },
        l = { description = 'Link', template = '* %?\n%a' },
        n = {
          description = 'Note',
          template = '* %?\n',
          target = mein_wissen_dir('orgfiles/notes.org'),
        },
        p = {
          description = 'Project Todo',
          template = '* TODO %? \nSCHEDULED: %t',
          target = mein_wissen_dir('orgfiles/projects.org'),
        },
      },
      win_border = border,
      mappings = { org = { org_global_cycle = '<leader><S-TAB>' } },
      notifications = {
        enabled = true,
        repeater_reminder_time = false,
        deadline_warning_reminder_time = true,
        reminder_time = 10,
        deadline_reminder = true,
        scheduled_reminder = true,
      },
    },
    config = function(_, opts)
      highlight.plugin('org', {
        { OrgDone = { fg = 'Green', bold = true } },
        { OrgAgendaScheduled = { fg = 'Teal' } },
      })
      require('orgmode').setup(opts)
    end,
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
        uuid_type = '%Y%m%d%H%M%s%z',
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
