local mein_wissen_path = os.getenv('MEIN_WISSEN_PATH')
if mein_wissen_path == nil or mein_wissen_path == '' then return {} end

local fmt, ui = string.format, vim.ui
local highlight, border = as.highlight, as.ui.current.border
local function sync(path) return fmt('%s/notes/%s', mein_wissen_path, path) end

return {
  {
    'nvim-neorg/neorg',
    ft = 'norg',
    version = '*',
    build = ':Neorg sync-parsers',
    opts = {
      configure_parsers = true,
      load = {
        ['core.defaults'] = {},
        ['core.completion'] = { config = { engine = 'nvim-cmp' } },
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = sync('neorg/notes/'),
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
      org_agenda_files = { sync('orgfiles/**/*') },
      org_default_notes_file = sync('orgfiles/refile.org'),
      org_todo_keywords = { 'TODO(t)', 'WAITING', 'IN-PROGRESS', '|', 'DONE(d)', 'CANCELLED' },
      org_todo_keyword_faces = {
        ['IN-PROGRESS'] = ':foreground royalblue :weight bold',
        ['CANCELLED'] = ':foreground darkred :weight bold',
      },
      org_hide_emphasis_markers = true,
      org_hide_leading_stars = true,
      org_agenda_skip_scheduled_if_done = true,
      org_agenda_skip_deadline_if_done = true,
      org_agenda_templates = {
        t = { description = 'Task', template = '* TODO %?\n %u' },
        l = { description = 'Link', template = '* %?\n%a' },
        n = { description = 'Note', template = '* %?\n', target = sync('orgfiles/notes.org') },
        p = {
          description = 'Project Todo',
          template = '* TODO %? \nSCHEDULED: %t',
          target = sync('orgfiles/projects.org'),
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
    cmd = 'Telekasten',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-telescope/telescope-symbols.nvim',
      'iamcco/markdown-preview.nvim',
    },
    config = function()
      require('telekasten').setup({
        home = mein_wissen_path,
        take_over_my_home = false,
        auto_set_filetype = false,
        auto_set_syntax = true,
        install_syntax = true,
      })
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
