local fn, api = vim.fn, vim.api
local highlight = as.highlight
local icons = as.ui.icons
local autocmd = api.nvim_create_autocmd

local oil_detail_view = false

return {
  {
    'mikavilpas/yazi.nvim',
    lazy = false,
    event = 'VeryLazy',
    opts = {
      log_level = vim.log.levels.DEBUG,
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = '<F1>',
      },
      future_features = {
        -- Whether to use `ya emit reveal` to reveal files in the file manager.
        -- Requires yazi 0.4.0 or later (from 2024-12-08).
        ya_emit_reveal = true,

        -- Use `ya emit open` as a more robust implementation for opening files
        -- in yazi. This can prevent conflicts with custom keymappings for the enter
        -- key. Requires yazi 0.4.0 or later (from 2024-12-08).
        ya_emit_open = true,
      },
    },
  },
  {
    'stevearc/oil.nvim',
    init = function()
      require('oil').setup({
        default_file_explorer = false,
        view_options = {
          show_hidden = true,
        },
        use_default_keymaps = false,
        delete_to_trash = true,
        case_insensitive = true,
        win_options = {
          wrap = false,
          signcolumn = 'yes',
          cursorcolumn = true,
          foldcolumn = '0',
          spell = true,
          list = true,
          conceallevel = 3,
          concealcursor = 'nvic',
        },
        keymaps = {
          ['g?'] = { 'actions.show_help', mode = 'n' },
          ['<CR>'] = 'actions.select',
          ['<localleader>ov'] = {
            'actions.select',
            opts = { vertical = true },
            desc = 'Open the entry in a vertical split',
          },
          ['<localleader>os'] = {
            'actions.select',
            opts = { horizontal = true },
            desc = 'Open the entry in a horizontal split',
          },
          ['<localleader>ot'] = {
            'actions.select',
            opts = { tab = true },
            desc = 'Open the entry in new tab',
          },
          ['<localleader>op'] = 'actions.preview',
          ['<localleader>oc'] = 'actions.close',
          ['<localleader>or'] = 'actions.refresh',
          ['<localleader>od'] = {
            desc = 'Toggle file detail view',
            callback = function()
              oil_detail_view = not oil_detail_view
              if oil_detail_view then
                require('oil').set_columns({ 'icon', 'permissions', 'size', 'mtime' })
              else
                require('oil').set_columns({ 'icon' })
              end
            end,
          },
          ['-'] = { 'actions.parent', mode = 'n' },
          ['_'] = { 'actions.open_cwd', mode = 'n' },
          ['`'] = { 'actions.cd', mode = 'n' },
          ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
          ['gs'] = { 'actions.change_sort', mode = 'n' },
          ['gx'] = 'actions.open_external',
          ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
          ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
        },
      })
    end,
    cmd = { 'Oil' },
    keys = {
      { '<F9>', '<Cmd>Oil<CR>', mode = 'n', desc = 'Open Oil parent directory' },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'echasnovski/mini.icons',
    },
  },
  -- {
  --   'nvim-neo-tree/neo-tree.nvim',
  --   branch = 'v3.x',
  --   cmd = { 'Neotree' },
  --   keys = { { '<C-N>', '<Cmd>Neotree toggle reveal<CR>', desc = 'NeoTree' } },
  --   init = function()
  --     autocmd('BufEnter', {
  --       desc = 'Load NeoTree if entering a directory',
  --       callback = function(args)
  --         if fn.isdirectory(api.nvim_buf_get_name(args.buf)) > 0 then
  --           require('lazy').load({ plugins = { 'neo-tree.nvim' } })
  --           api.nvim_del_autocmd(args.id)
  --         end
  --       end,
  --     })
  --   end,
  --   config = function()
  --     highlight.plugin('NeoTree', {
  --       theme = {
  --         ['*'] = {
  --           { NeoTreeNormal = { link = 'PanelBackground' } },
  --           { NeoTreeNormalNC = { link = 'PanelBackground' } },
  --           { NeoTreeCursorLine = { link = 'Visual' } },
  --           { NeoTreeRootName = { underline = true } },
  --           { NeoTreeStatusLine = { link = 'PanelSt' } },
  --           { NeoTreeTabActive = { bg = { from = 'PanelBackground' }, bold = true } },
  --           {
  --             NeoTreeTabInactive = {
  --               bg = { from = 'PanelDarkBackground', alter = 0.15 },
  --               fg = { from = 'Comment' },
  --             },
  --           },
  --           {
  --             NeoTreeTabSeparatorActive = { inherit = 'PanelBackground', fg = { from = 'Comment' } },
  --           },
  --           -- stylua: ignore
  --           { NeoTreeTabSeparatorInactive = { inherit = 'NeoTreeTabInactive', fg = { from = 'PanelDarkBackground', attr = 'bg' } } },
  --         },
  --         -- NOTE: panel background colours don't get ignored by tint.nvim so avoid using them for now
  --         horizon = {
  --           { NeoTreeWinSeparator = { link = 'WinSeparator' } },
  --           { NeoTreeTabActive = { link = 'VisibleTab' } },
  --           { NeoTreeTabSeparatorActive = { link = 'VisibleTab' } },
  --           { NeoTreeTabInactive = { inherit = 'Comment', italic = false } },
  --           { NeoTreeTabSeparatorInactive = { bg = 'bg', fg = 'bg' } },
  --         },
  --       },
  --     })
  --
  --     local symbols = require('lspkind').symbol_map
  --     local lsp_kinds = as.ui.lsp.highlights
  --
  --     require('neo-tree').setup({
  --       sources = { 'filesystem', 'git_status', 'document_symbols' },
  --       source_selector = {
  --         winbar = true,
  --         separator_active = '',
  --         sources = {
  --           { source = 'filesystem' },
  --           { source = 'git_status' },
  --           { source = 'document_symbols' },
  --         },
  --       },
  --       enable_git_status = true,
  --       git_status_async = true,
  --       nesting_rules = {
  --         ['dart'] = { 'freezed.dart', 'g.dart' },
  --         ['go'] = {
  --           pattern = '(.*)%.go$',
  --           files = { '%1_test.go' },
  --         },
  --         ['docker'] = {
  --           pattern = '^dockerfile$',
  --           ignore_case = true,
  --           files = { '.dockerignore', 'docker-compose.*', 'dockerfile*' },
  --         },
  --       },
  --       event_handlers = {
  --         {
  --           event = 'neo_tree_buffer_enter',
  --           handler = function() highlight.set('Cursor', { blend = 100 }) end,
  --         },
  --         {
  --           event = 'neo_tree_popup_buffer_enter',
  --           handler = function() highlight.set('Cursor', { blend = 0 }) end,
  --         },
  --         {
  --           event = 'neo_tree_buffer_leave',
  --           handler = function() highlight.set('Cursor', { blend = 0 }) end,
  --         },
  --         {
  --           event = 'neo_tree_popup_buffer_leave',
  --           handler = function() highlight.set('Cursor', { blend = 100 }) end,
  --         },
  --         {
  --           event = 'neo_tree_window_after_close',
  --           handler = function() highlight.set('Cursor', { blend = 0 }) end,
  --         },
  --         {
  --           event = 'neo_tree_popup_input_ready',
  --           handler = function() vim.cmd('stopinsert') end,
  --         },
  --       },
  --       filesystem = {
  --         hijack_netrw_behavior = 'disabled',
  --         use_libuv_file_watcher = true,
  --         group_empty_dirs = false,
  --         follow_current_file = {
  --           enabled = true,
  --           leave_dirs_open = true,
  --         },
  --         filtered_items = {
  --           visible = true,
  --           hide_dotfiles = false,
  --           hide_gitignored = true,
  --           never_show = { '.DS_Store' },
  --         },
  --         window = {
  --           mappings = {
  --             ['/'] = 'noop',
  --             ['g/'] = 'fuzzy_finder',
  --           },
  --         },
  --       },
  --       default_component_configs = {
  --         icon = { folder_empty = icons.documents.open_folder },
  --         name = { highlight_opened_files = true },
  --         document_symbols = {
  --           follow_cursor = true,
  --           kinds = vim.iter(symbols):fold({}, function(acc, k, v)
  --             acc[k] = { icon = v, hl = lsp_kinds[k] }
  --             return acc
  --           end),
  --         },
  --         modified = { symbol = icons.misc.circle .. ' ' },
  --         git_status = {
  --           symbols = {
  --             added = icons.git.add,
  --             deleted = icons.git.remove,
  --             modified = icons.git.mod,
  --             renamed = icons.git.rename,
  --             untracked = icons.git.untracked,
  --             ignored = icons.git.ignored,
  --             unstaged = icons.git.unstaged,
  --             staged = icons.git.staged,
  --             conflict = icons.git.conflict,
  --           },
  --         },
  --         file_size = {
  --           required_width = 50,
  --         },
  --       },
  --       window = {
  --         mappings = {
  --           ['o'] = 'toggle_node',
  --           ['<cr>'] = 'open',
  --           ['<c-o>'] = 'open_with_window_picker',
  --           ['<c-s>'] = 'split_with_window_picker',
  --           ['<c-v>'] = 'vsplit_with_window_picker',
  --           ['<esc>'] = 'revert_preview',
  --           ['P'] = { 'toggle_preview', config = { use_float = true } },
  --         },
  --       },
  --     })
  --   end,
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --     {
  --       'ten3roberts/window-picker.nvim',
  --       name = 'window-picker',
  --       config = function()
  --         local picker = require('window-picker')
  --         picker.setup()
  --         picker.pick_window = function()
  --           return picker.select(
  --             { hl = 'WindowPicker', prompt = 'Pick window: ' },
  --             function(winid) return winid or nil end
  --           )
  --         end
  --       end,
  --     },
  --   },
  -- },
  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    config = function()
      as.highlight.plugin('marks', {
        { MarkSignHL = { link = 'Directory' } },
        { MarkSignNumHL = { link = 'Directory' } },
      })
      map('n', '<leader>mb', '<Cmd>MarksListBuf<CR>', { desc = 'list buffer' })
      map('n', '<leader>mg', '<Cmd>MarksQFListGlobal<CR>', { desc = 'list global' })
      map('n', '<leader>m0', '<Cmd>BookmarksQFList 0<CR>', { desc = 'list bookmark' })

      require('marks').setup({
        force_write_shada = false, -- This can cause data loss
        excluded_filetypes = { 'NeogitStatus', 'NeogitCommitMessage', 'toggleterm' },
        bookmark_0 = { sign = '⚑', virt_text = '' },
        mappings = { annotate = 'm?' },
      })
    end,
  },
}
