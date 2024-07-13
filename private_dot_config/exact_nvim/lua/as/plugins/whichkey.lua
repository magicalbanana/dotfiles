local highlight = as.highlight

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    highlight.plugin('whichkey', {
      theme = {
        ['*'] = { { WhichkeyFloat = { link = 'NormalFloat' } } },
        horizon = { { WhichKeySeparator = { link = 'Todo' } } },
      },
    })

    local wk = require('which-key')
    wk.setup({
      plugins = { spelling = { enabled = true } },
      window = { border = as.ui.current.border },
      layout = { align = 'center' },
    })

    wk.add({
      { '<leader>O', group = 'options' },
      { '<leader>a', group = 'projectionist' },
      { '<leader>c', group = 'code-action' },
      { '<leader>e', group = 'edit' },
      { '<leader>f', group = 'picker' },
      { '<leader>h', group = 'git-action' },
      { '<leader>i', group = 'iswap' },
      { '<leader>j', group = 'jump' },
      { '<leader>l', group = 'list' },
      { '<leader>n', group = 'new' },
      { '<leader>o', group = 'only' },
      { '<leader>p', group = 'packages' },
      { '<leader>q', group = 'quit' },
      { '<leader>r', group = 'lsp-refactor' },
      { '<leader>s', group = 'source/swap' },
      { '<leader>t', group = 'tab' },
      { '<leader>y', group = 'yank' },
      { '<localleader>', group = 'local leader' },
      { '<localleader>d', group = 'dap' },
      { '<localleader>g', group = 'git' },
      { '<localleader>o', group = 'neorg' },
      { '<localleader>t', group = 'neotest' },
      { '<localleader>w', group = 'window' },
      { '[', group = 'prev' },
      { ']', group = 'next' },
      { 'gb', group = 'bufferline' },
      { 'gc', group = 'comment' },
    })
  end,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'echasnovski/mini.icons',
  },
}
