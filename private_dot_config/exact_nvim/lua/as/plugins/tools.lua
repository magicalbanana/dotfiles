return {
  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
        javascript = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        pgsql = { "sql_formatter" },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
      },
      format_on_save = function(buf)
        if vim.g.formatting_disabled or vim.b[buf].formatting_disabled then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    },
    config = function(_, opts)
      require("conform").setup(opts)
      require("conform.formatters.sql_formatter").args = function(ctx)
        local config_path = ctx.dirname .. "/.sql-formatter.json"
        if vim.uv.fs_stat(config_path) then
          return { "--config", config_path }
        end
        return { "--language", "postgresql" }
      end
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "BufReadPre",
    init = function()
      vim.api.nvim_create_autocmd({ "TextChanged" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
    config = function()
      require("lint").linters_by_ft = {
        dockerfile = { "hadolint" },
        fennel = { "fennel" },
        go = { "golangcilint" },
        javascript = { "eslint" },
        json = { "jsonlint" },
        markdown = { "markdownlint" },
        python = { "pylint" },
        ruby = { "rubocop" },
        sh = { "shellharden", "shellcheck" },
        sql = { "sqlformatter" },
        yaml = { "yamllint" },
      }
    end,
  },
}
