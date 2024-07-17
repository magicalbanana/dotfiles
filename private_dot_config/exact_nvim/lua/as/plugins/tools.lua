local parrot_cmd_prefix = 'Prt'
return {
  {
    'terrastruct/d2-vim',
    lazy = false,
  },
  {
    'frankroeder/parrot.nvim',
    lazy = false,
    dependencies = {
      'ibhagwan/fzf-lua',
      'nvim-lua/plenary.nvim',
    },
    cond = os.getenv('OPENAI_API_KEY_PARROT_NVIM') ~= nil or os.getenv(
      'ANTHROPIC_API_KEY_PARROT_NVIM'
    ) ~= nil or os.getenv('GEMINI_API_KEY_PARROT_NVIM') ~= nil,
    config = function()
      require('parrot').setup({
        providers = {
          openai = {
            api_key = os.getenv('PARROT_NVIM_OPENAI_API_KEY'),
          },
          anthropic = {
            api_key = os.getenv('PARROT_NVIM_ANTHROPIC_API_KEY'),
          },
          gemini = {
            api_key = os.getenv('PARROT_NVIM_GEMINI_API_KEY'),
          },
        },
        cmd_prefx = parrot_cmd_prefix,
      })
    end,
  },
  {
    'pasky/claude.vim',
    lazy = false,
    enabled = true,
    cond = os.getenv('ANTHROPIC_API_KEY_CLAUDE_VIM') ~= nil,
    init = function() vim.g.claude_api_key = os.getenv('ANTHROPIC_API_KEY_CLAUDE_VIM') end,
  },
  {
    'stevearc/conform.nvim',
    lazy = false,
    event = 'BufReadPre',
    opts = {
      formatters_by_ft = {
        go = { 'goimports', 'gofumpt' },
        javascript = { { 'prettierd', 'prettier' } },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        markdown = { 'prettier' },
        pgsql = { 'sql_formatter' },
        sh = { 'shfmt' },
        sql = { 'sql_formatter' },
      },
      format_on_save = function(buf)
        if vim.g.formatting_disabled or vim.b[buf].formatting_disabled then return end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    },
    config = function(_, opts)
      require('conform').setup(opts)
      require('conform.formatters.sql_formatter').args = function(ctx)
        local config_path = ctx.cwd .. '/.sql-formatter.json'
        if vim.uv.fs_stat(config_path) then return { '--config', config_path } end
        return { '--language', 'postgresql' }
      end
    end,
  },
  {
    'mfussenegger/nvim-lint',
    lazy = false,
    event = 'BufReadPre',
    init = function()
      vim.api.nvim_create_autocmd({ 'TextChanged' }, {
        callback = function() require('lint').try_lint() end,
      })
    end,
    config = function()
      require('lint').linters_by_ft = {
        javascript = { 'eslint' },
        markdown = { 'markdownlint' },
        go = { 'golangcilint' },
      }
    end,
  },
}
