local highlight, ui, k = as.highlight, as.ui, vim.keycode
local api, fn = vim.api, vim.fn

return {
  {
    'f3fora/cmp-spell',
    ft = {
      'gitcommit',
      'NeogitCommitMessage',
      'markdown',
    },
  },
  { 'rcarriga/cmp-dap' },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-emoji' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'lukas-reineke/cmp-rg' },
      { 'petertriho/cmp-git', opts = { filetypes = { 'gitcommit', 'NeogitCommitMessage' } } },
      { 'abecodes/tabout.nvim', opts = { ignore_beginning = false, completion = false } },
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')
      local ellipsis = ui.icons.misc.ellipsis
      local MIN_MENU_WIDTH, MAX_MENU_WIDTH = 25, math.min(50, math.floor(vim.o.columns * 0.5))

      highlight.plugin('Cmp', {
        { CmpItemKindVariable = { link = 'Variable' } },
        { CmpItemAbbrMatchFuzzy = { inherit = 'CmpItemAbbrMatch', italic = true } },
        { CmpItemAbbrDeprecated = { strikethrough = true, inherit = 'Comment' } },
        { CmpItemMenu = { inherit = 'Comment', italic = true } },
      })

      local function shift_tab(fallback)
        if not cmp.visible() then return fallback() end
        if luasnip.jumpable(-1) then luasnip.jump(-1) end
      end

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
      end

      cmp.setup({
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        window = {
          completion = cmp.config.window.bordered({
            border = 'single',
            winhighlight = 'NormalFloat:Normal,CursorLine:PmenuSel,FloatBorder:PickerBorder',
          }),
          documentation = cmp.config.window.bordered({
            border = 'single',
            winhighlight = 'NormalFloat:Normal,FloatBorder:PickerBorder',
          }),
        },
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          -- ['<C-]>'] = cmp.mapping(copilot),
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i' }),
          ['<C-space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<S-TAB>'] = cmp.mapping(shift_tab, { 'i', 's' }),
          ['<Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
        }),
        formatting = {
          expandable_indicator = true,
          fields = { 'kind', 'abbr', 'menu' },
          format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = MAX_MENU_WIDTH,
            ellipsis_char = ellipsis,
            before = function(_, vim_item)
              local label, length = vim_item.abbr, api.nvim_strwidth(vim_item.abbr)
              if length < MIN_MENU_WIDTH then vim_item.abbr = label .. string.rep(' ', MIN_MENU_WIDTH - length) end
              return vim_item
            end,
            menu = {
              nvim_lsp = '',
              nvim_lua = '',
              copilot = '',
              emoji = '󰞅',
              path = '',
              luasnip = '',
              dictionary = '',
              buffer = '',
              spell = '',
              rg = '',
              git = '',
            },
          }),
        },
        sources = {
          { name = 'lazydev', group_index = 0 },
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'luasnip', group_index = 1 },
          { name = 'copilot', group_index = 1 },
          { name = 'path', group_index = 1 },
          {
            name = 'rg',
            keyword_length = 4,
            option = { additional_arguments = '--max-depth 8' },
            group_index = 1,
          },
          {
            name = 'buffer',
            options = { get_bufnrs = function() return vim.api.nvim_list_bufs() end },
            group_index = 2,
          },
          { name = 'spell', group_index = 2 },
        },
      })

      cmp.setup.filetype({ 'dap-repl', 'dapui_watches' }, { sources = { { name = 'dap' } } })
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    event = { 'InsertEnter', 'LspAttach' },
    config = function()
      require('copilot_cmp').setup({
        event = { 'InsertEnter', 'LspAttach' },
        fix_pairs = true,
      })
    end,
    dependencies = {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      config = function()
        require('copilot').setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
      end,
    },
  },
}
