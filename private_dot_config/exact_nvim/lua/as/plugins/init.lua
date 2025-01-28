local opt, api, fn, cmd, fmt = vim.opt, vim.api, vim.fn, vim.cmd, string.format
local border, highlight, icons = as.ui.current.border, as.highlight, as.ui.icons

vim.g.rainbow_delimiters = {
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
}

return {
  -----------------------------------------------------------------------------//
  -- Core {{{3
  -----------------------------------------------------------------------------//
  'nvim-lua/plenary.nvim', -- THE LIBRARY
  'nvim-tree/nvim-web-devicons',
  'echasnovski/mini.icons',
  -- {
  --   '3rd/image.nvim',
  --   disable = true,
  --   ft = { 'markdown' },
  --   opts = {},
  -- },
  {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
    },
    opts = {},
  },
  {
    'olimorris/persisted.nvim',
    lazy = false,
    init = function()
      as.augroup('PersistedEvents', {
        event = 'User',
        pattern = 'PersistedSavePre',
        -- Arguments are always persisted in a session and can't be removed using 'sessionoptions'
        -- so remove them when saving a session
        command = function() cmd('%argdelete') end,
      })
    end,
    opts = {
      use_git_branch = true,
      allowed_dirs = { vim.g.dotfiles, vim.g.dev_workspace_root },
      ignored_dirs = { fn.stdpath('data') },
    },
  },
  {
    'mrjones2014/smart-splits.nvim',
    opts = {},
    build = './kitty/install-kittens.bash',
    keys = {
      { '<A-h>', function() require('smart-splits').resize_left() end },
      { '<A-l>', function() require('smart-splits').resize_right() end },
      -- moving between splits
      { '<C-h>', function() require('smart-splits').move_cursor_left() end },
      { '<C-j>', function() require('smart-splits').move_cursor_down() end },
      { '<C-k>', function() require('smart-splits').move_cursor_up() end },
      { '<C-l>', function() require('smart-splits').move_cursor_right() end },
      -- swapping buffers between windows
      {
        '<leader><leader>h',
        function() require('smart-splits').swap_buf_left() end,
        desc = 'swap left',
      },
      {
        '<leader><leader>j',
        function() require('smart-splits').swap_buf_down() end,
        desc = 'swap down',
      },
      {
        '<leader><leader>k',
        function() require('smart-splits').swap_buf_up() end,
        desc = 'swap up',
      },
      {
        '<leader><leader>l',
        function() require('smart-splits').swap_buf_right() end,
        desc = 'swap right',
      },
    },
  },
  -- }}}
  -----------------------------------------------------------------------------//
  -- LSP,Completion & Debugger {{{1
  -----------------------------------------------------------------------------//
  'onsails/lspkind.nvim',
  'b0o/schemastore.nvim',
  {
    'kosayoda/nvim-lightbulb',
    event = 'LspAttach',
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = false },
      float = { text = icons.misc.lightbulb, enabled = true, win_opts = { border = 'none' } },
    },
  },
  {
    {
      'williamboman/mason.nvim',
      cmd = 'Mason',
      build = ':MasonUpdate',
      opts = { ui = { border = border, height = 0.8 } },
    },
    {
      'williamboman/mason-lspconfig.nvim',
      event = { 'BufReadPre', 'BufNewFile' },
      dependencies = {
        'mason.nvim',
        {
          'neovim/nvim-lspconfig',
          dependencies = {
            { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
            {
              'folke/neoconf.nvim',
              cmd = { 'Neoconf' },
              opts = { local_settings = '.nvim.json', global_settings = 'nvim.json' },
            },
          },
          config = function()
            highlight.plugin('lspconfig', { { LspInfoBorder = { link = 'FloatBorder' } } })
            require('lspconfig.ui.windows').default_options.border = border
            require('lspconfig').ccls.setup(require('as.servers')('ccls'))
          end,
        },
      },
      opts = {
        automatic_installation = true,
        handlers = {
          function(name)
            local config = require('as.servers')(name)
            if config then require('lspconfig')[name].setup(config) end
          end,
        },
      },
    },
  },
  {
    'MysticalDevil/inlay-hints.nvim',
    event = 'LspAttach',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function() require('inlay-hints').setup() end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = { library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } } },
  },
  {
    'DNLHC/glance.nvim',
    opts = {
      preview_win_opts = { relativenumber = false },
      theme = { enable = true, mode = 'darken' },
    },
    keys = {
      { 'gD', '<Cmd>Glance definitions<CR>', desc = 'lsp: glance definitions' },
      { 'gR', '<Cmd>Glance references<CR>', desc = 'lsp: glance references' },
      { 'gY', '<Cmd>Glance type_definitions<CR>', desc = 'lsp: glance type definitions' },
      { 'gM', '<Cmd>Glance implementations<CR>', desc = 'lsp: glance implementations' },
    },
  },
  {
    'smjonas/inc-rename.nvim',
    opts = { hl_group = 'Visual', preview_empty_name = true },
    keys = {
      {
        '<leader>rn',
        function() return fmt(':IncRename %s', fn.expand('<cword>')) end,
        expr = true,
        silent = false,
        desc = 'lsp: incremental rename',
      },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  -- }}}
  -----------------------------------------------------------------------------//
  -- UI {{{1
  -----------------------------------------------------------------------------//
  {
    'uga-rosa/ccc.nvim',
    ft = { 'typescript', 'typescriptreact', 'javascriptreact', 'svelte' },
    cmd = { 'CccHighlighterToggle' },
    config = function()
      local ccc = require('ccc')
      local p = ccc.picker
      ccc.setup({
        win_opts = { border = border },
        pickers = { p.hex_long, p.css_rgb, p.css_hsl, p.css_hwb, p.css_lab, p.css_lch, p.css_oklab, p.css_oklch },
        highlighter = {
          auto_enable = true,
          excludes = { 'lazy', 'orgagenda', 'org', 'NeogitStatus', 'toggleterm' },
        },
      })
    end,
  },
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('todo-comments').setup()
      as.command('TodoDots', ('TodoQuickFix cwd=%s keywords=TODO,FIXME'):format(vim.g.vim_dir))
    end,
  },
  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    init = function()
      highlight.plugin('SymbolUsage', {
        { SymbolUsageRounding = { fg = { from = 'CursorLine', attr = 'bg' }, italic = true } },
        { SymbolUsageContent = { bg = { from = 'CursorLine' }, fg = { from = 'Comment' } } },
        { SymbolUsageRef = { fg = { from = 'Function' }, bg = { from = 'CursorLine' }, italic = true } },
        { SymbolUsageDef = { fg = { from = 'Type' }, bg = { from = 'CursorLine' }, italic = true } },
        { SymbolUsageImpl = { fg = { from = 'Keyword' }, bg = { from = 'CursorLine' }, italic = true } },
      })
    end,
    config = {
      text_format = function(symbol)
        local res = {}
        local ins = table.insert

        local round_start = { '', 'SymbolUsageRounding' }
        local round_end = { '', 'SymbolUsageRounding' }

        if symbol.references then
          local usage = symbol.references <= 1 and 'usage' or 'usages'
          local num = symbol.references == 0 and 'no' or symbol.references
          ins(res, round_start)
          ins(res, { '󰌹 ', 'SymbolUsageRef' })
          ins(res, { ('%s %s'):format(num, usage), 'SymbolUsageContent' })
          ins(res, round_end)
        end

        if symbol.definition then
          if #res > 0 then table.insert(res, { ' ', 'NonText' }) end
          ins(res, round_start)
          ins(res, { '󰳽 ', 'SymbolUsageDef' })
          ins(res, { symbol.definition .. ' defs', 'SymbolUsageContent' })
          ins(res, round_end)
        end

        if symbol.implementation then
          if #res > 0 then table.insert(res, { ' ', 'NonText' }) end
          ins(res, round_start)
          ins(res, { '󰡱 ', 'SymbolUsageImpl' })
          ins(res, { symbol.implementation .. ' impls', 'SymbolUsageContent' })
          ins(res, round_end)
        end

        return res
      end,
    },
  },
  -- }}}
  --------------------------------------------------------------------------------
  -- Utilities {{{1
  --------------------------------------------------------------------------------
  {
    'famiu/bufdelete.nvim',
    keys = { { '<leader>qq', '<Cmd>Bdelete<CR>', desc = 'buffer delete' } },
  },
  {
    'folke/flash.nvim',
    opts = {
      modes = {
        char = {
          keys = { 'f', 'F', 't', 'T', ';' }, -- remove "," from keys },
          search = { enabled = false },
        },
        jump = { nohlsearch = true },
      },
      keys = {
        { 's', function() require('flash').jump() end, mode = { 'n', 'x', 'o' } },
        { 'S', function() require('flash').treesitter() end, mode = { 'o', 'x' } },
        { 'r', function() require('flash').remote() end, mode = 'o', desc = 'Remote Flash' },
        { '<c-s>', function() require('flash').toggle() end, mode = { 'c' }, desc = 'Toggle Flash Search' },
        {
          'R',
          function() require('flash').treesitter_search() end,
          mode = { 'o', 'x' },
          desc = 'Flash Treesitter Search',
        },
      },
    },
  },
  {
    'chaoren/vim-wordmotion',
    lazy = false,
    init = function() vim.g.wordmotion_spaces = { '-', '_', '\\/', '\\.' } end,
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    keys = { { 's', mode = 'v' }, '<C-g>s', '<C-g>S', 'ys', 'yss', 'yS', 'cs', 'ds' },
    opts = { move_cursor = true, keymaps = { visual = 's' } },
  },
  {
    'andrewferrier/debugprint.nvim',
    opts = { create_keymaps = false },
    keys = {
      {
        '<leader>dp',
        function() return require('debugprint').debugprint({ variable = true }) end,
        desc = 'debugprint: cursor',
        expr = true,
      },
      {
        '<leader>do',
        function() return require('debugprint').debugprint({ motion = true }) end,
        desc = 'debugprint: operator',
        expr = true,
      },
      { '<leader>dC', '<Cmd>DeleteDebugPrints<CR>', desc = 'debugprint: clear all' },
    },
  },
  {
    'jghauser/fold-cycle.nvim',
    opts = {},
    keys = {
      { '<BS>', function() require('fold-cycle').open() end, desc = 'fold-cycle: toggle' },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
        close_triple_quotes = true,
        disable_filetype = { 'neo-tree-popup' },
        check_ts = true,
        fast_wrap = { map = '<c-e>' },
        ts_config = {
          lua = { 'string' },
          javascript = { 'template_string' },
        },
      })
    end,
  },
  {
    'karb94/neoscroll.nvim', -- NOTE: alternative: 'declancm/cinnamon.nvim'
    event = 'VeryLazy',
    opts = { hide_cursor = true, mappings = { '<C-d>', '<C-u>', 'zt', 'zz', 'zb' } },
  },
  {
    'itchyny/vim-highlighturl',
    event = 'ColorScheme',
    config = function() vim.g.highlighturl_guifg = highlight.get('@keyword', 'fg') end,
  },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = { { '<leader>u', '<Cmd>UndotreeToggle<CR>', desc = 'undotree: toggle' } },
    config = function()
      vim.g.undotree_TreeNodeShape = '◦' -- Alternative: '◉'
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    'willothy/flatten.nvim',
    dependencies = { 'willothy/wezterm.nvim' },
    opts = function()
      ---@type Terminal?
      local saved_terminal

      return {
        window = {
          open = 'alternate',
        },
        hooks = {
          should_block = function(argv)
            -- Note that argv contains all the parts of the CLI command, including
            -- Neovim's path, commands, options and files.
            -- See: :help v:argv

            -- In this case, we would block if we find the `-b` flag
            -- This allows you to use `nvim -b file1` instead of
            -- `nvim --cmd 'let g:flatten_wait=1' file1`
            return vim.tbl_contains(argv, '-b')

            -- Alternatively, we can block if we find the diff-mode option
            -- return vim.tbl_contains(argv, "-d")
          end,
          pre_open = function()
            local term = require('toggleterm.terminal')
            local termid = term.get_focused_id()
            saved_terminal = term.get(termid)
          end,
          post_open = function(bufnr, winnr, ft, is_blocking)
            if is_blocking and saved_terminal then
              -- Hide the terminal while it's blocking
              saved_terminal:close()
            else
              -- If it's a normal file, just switch to its window
              api.nvim_set_current_win(winnr)

              -- If we're in a different wezterm pane/tab, switch to the current one
              -- Requires willothy/wezterm.nvim
              require('wezterm').switch_pane.id(tonumber(os.getenv('WEZTERM_PANE')))
            end

            -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
            -- If you just want the toggleable terminal integration, ignore this bit
            if ft == 'gitcommit' or ft == 'gitrebase' then
              vim.api.nvim_create_autocmd('BufWritePost', {
                buffer = bufnr,
                once = true,
                callback = vim.schedule_wrap(function() vim.api.nvim_buf_delete(bufnr, {}) end),
              })
            end
          end,
          block_end = function()
            -- After blocking ends (for a git commit, etc), reopen the terminal
            vim.schedule(function()
              if saved_terminal then
                saved_terminal:open()
                saved_terminal = nil
              end
            end)
          end,
        },
      }
    end,
  },
  -----------------------------------------------------------------------------//
  -- Quickfix
  -----------------------------------------------------------------------------//
  {
    'yorickpeterse/nvim-pqf',
    event = 'VeryLazy',
    config = function() require('pqf').setup() end,
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function() highlight.plugin('bqf', { { BqfPreviewBorder = { fg = { from = 'Comment' } } } }) end,
  },
  -- }}}
  --------------------------------------------------------------------------------
  -- TPOPE {{{1
  --------------------------------------------------------------------------------
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = 'tpope/vim-dadbod',
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection' },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      map('n', '<leader>db', '<cmd>DBUIToggle<CR>', { desc = 'dadbod: toggle' })
    end,
  },
  { 'tpope/vim-eunuch', cmd = { 'Move', 'Rename', 'Remove', 'Delete', 'Mkdir' } },
  { 'tpope/vim-sleuth', event = 'VeryLazy' },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  {
    'tpope/vim-abolish',
    event = 'CmdlineEnter',
    keys = {
      {
        '<localleader>[',
        ':S/<C-R><C-W>//<LEFT>',
        mode = 'n',
        silent = false,
        desc = 'abolish: replace word under the cursor (line)',
      },
      {
        '<localleader>]',
        ':%S/<C-r><C-w>//c<left><left>',
        mode = 'n',
        silent = false,
        desc = 'abolish: replace word under the cursor (file)',
      },
      {
        '<localleader>[',
        [["zy:'<'>S/<C-r><C-o>"//c<left><left>]],
        mode = 'x',
        silent = false,
        desc = 'abolish: replace word under the cursor (visual)',
      },
    },
  },
  -- }}}
  -----------------------------------------------------------------------------//
  -- Filetype Plugins {{{1
  -----------------------------------------------------------------------------//
  { 'lifepillar/pgsql.vim', lazy = false },
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function() require('go').setup() end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    'iamcco/markdown-preview.nvim',
    build = function() fn['mkdp#util#install']() end,
    ft = { 'markdown' },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
    end,
  },
  {
    'saecki/crates.nvim',
    version = '*',
    event = 'BufRead Cargo.toml',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      popup = { border = border },
    },
    config = function(_, opts)
      as.augroup('CmpSourceCargo', {
        event = 'BufRead',
        pattern = 'Cargo.toml',
        command = function() require('cmp').setup.buffer({ sources = { { name = 'crates' } } }) end,
      })
      require('crates').setup(opts)
    end,
  },
  { 'dmmulroy/tsc.nvim', cmd = 'TSC', opts = {}, ft = { 'typescript', 'typescriptreact' } },
  {
    'pmizio/typescript-tools.nvim',
    lazy = false,
    ft = { 'typescript', 'typescriptreact' },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = 'literal',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  { 'fladson/vim-kitty', lazy = false },
  -- }}}
  --------------------------------------------------------------------------------
  -- Syntax {{{1
  --------------------------------------------------------------------------------
  {
    'psliwka/vim-dirtytalk',
    lazy = false,
    build = ':DirtytalkUpdate',
    config = function() opt.spelllang:append('programming') end,
  },
  ---}}}
  --------------------------------------------------------------------------------
  -- Editing {{{1
  --------------------------------------------------------------------------------
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter' },
    opts = { use_default_keymaps = false },
    keys = {
      { 'gS', '<Cmd>TSJSplit<CR>', desc = 'split expression to multiple lines' },
      { 'gJ', '<Cmd>TSJJoin<CR>', desc = 'join expression to single line' },
    },
  },
  {
    'Wansmer/sibling-swap.nvim',
    keys = { ']w', '[w' },
    dependencies = { 'nvim-treesitter' },
    opts = {
      use_default_keymaps = true,
      highlight_node_at_cursor = true,
      keymaps = {
        [']w'] = 'swap_with_left',
        ['[w'] = 'swap_with_right',
      },
    },
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
        },
        query = {
          [''] = 'rainbow-delimiters',
        },
      }
    end,
  },
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    config = function() require('mini.ai').setup({ mappings = { around_last = '', inside_last = '' } }) end,
  },
  {
    'glts/vim-textobj-comment',
    dependencies = { { 'kana/vim-textobj-user', dependencies = { 'kana/vim-operator-user' } } },
    init = function() vim.g.textobj_comment_no_default_key_mappings = 1 end,
    keys = {
      { 'ax', '<Plug>(textobj-comment-a)', mode = { 'x', 'o' } },
      { 'ix', '<Plug>(textobj-comment-i)', mode = { 'x', 'o' } },
    },
  },
  {
    'assistcontrol/readline.nvim',
    keys = {
      { '<M-f>', function() require('readline').forward_word() end, mode = '!' },
      { '<M-b>', function() require('readline').backward_word() end, mode = '!' },
      { '<C-a>', function() require('readline').beginning_of_line() end, mode = '!' },
      { '<C-e>', function() require('readline').end_of_line() end, mode = '!' },
      { '<M-d>', function() require('readline').kill_word() end, mode = '!' },
      { '<M-BS>', function() require('readline').backward_kill_word() end, mode = '!' },
      { '<C-w>', function() require('readline').unix_word_rubout() end, mode = '!' },
      { '<C-k>', function() require('readline').kill_line() end, mode = '!' },
      { '<C-u>', function() require('readline').backward_kill_line() end, mode = '!' },
    },
  },
  -- }}}
  ---------------------------------------------------------------------------------
  -- Dev plugins  {{{1
  ---------------------------------------------------------------------------------
  { 'tweekmonster/helpful.vim', cmd = 'HelpfulVersion', ft = 'help' },
  { 'rafcamlet/nvim-luapad', cmd = 'Luapad' },
  -- }}}
}
--}}}
---------------------------------------------------------------------------------
-- vim:foldmethod=marker nospell
