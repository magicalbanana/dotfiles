-- local oil_detail_view = false

return {
  {
    'mikavilpas/yazi.nvim',
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
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>-',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        -- Open in the current working directory
        '<leader>cw',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
  },
  {
    'stevearc/oil.nvim',
    lazy = true,
    cmd = 'Oil',
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
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
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
