return {
  {
    'terrastruct/d2-vim',
  },
  {
    'frankroeder/parrot.nvim',
    tag = "v0.3.1",
    dependencies = {
      'ibhagwan/fzf-lua',
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require("parrot").setup {
        providers = {
          openai = {
            api_key = os.getenv 'PARROT_NVIM_OPENAI_API_KEY',
          },
          anthropic = {
            api_key = os.getenv 'PARROT_NVIM_ANTHROPIC_API_KEY',
          },
          -- pplx = {
          --   api_key = os.getenv "PERPLEXITY_API_KEY",
          --   -- OPTIONAL
          --   -- gpg command
          --   -- api_key = { "gpg", "--decrypt", vim.fn.expand("$HOME") .. "/pplx_api_key.txt.gpg"  },
          --   -- macOS security tool
          --   -- api_key = { "/usr/bin/security", "find-generic-password", "-s pplx-api-key", "-w" },
          -- },
          -- mistral = {
          --   api_key = os.getenv "MISTRAL_API_KEY",
          -- },
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
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
        local config_path = ctx.dirname .. '/.sql-formatter.json'
        if vim.uv.fs_stat(config_path) then return { '--config', config_path } end
        return { '--language', 'postgresql' }
      end
    end,
  },
  {
    'mfussenegger/nvim-lint',
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
