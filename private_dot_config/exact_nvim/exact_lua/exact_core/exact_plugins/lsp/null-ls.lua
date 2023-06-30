local nls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nls.setup({
  sources = {
    nls.builtins.diagnostics.actionlint,
    nls.builtins.diagnostics.buf,
    nls.builtins.diagnostics.checkmake,
    nls.builtins.diagnostics.commitlint,
    nls.builtins.diagnostics.dotenv_linter,
    nls.builtins.diagnostics.eslint_d,
    nls.builtins.diagnostics.hadolint,
    nls.builtins.diagnostics.luacheck,
    nls.builtins.diagnostics.markdownlint,
    nls.builtins.diagnostics.protolint,
    nls.builtins.diagnostics.ruff,
    nls.builtins.diagnostics.sqlfluff.with({
      extra_args = { "--dialect", "postgres" },
    }),
    nls.builtins.diagnostics.tfsec,
    nls.builtins.diagnostics.yamllint,

    nls.builtins.formatting.black,
    nls.builtins.formatting.gofumpt,
    nls.builtins.formatting.goimports,
    nls.builtins.formatting.just,
    nls.builtins.formatting.latexindent.with({
      extra_args = { "-g", "/dev/null" }, -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
    }),
    nls.builtins.formatting.markdownlint,
    nls.builtins.formatting.prettierd,
    nls.builtins.formatting.prettier.with({
      extra_args = { "--single-quote", "false" },
    }),
    nls.builtins.formatting.protolint,
    nls.builtins.formatting.rustfmt,
    nls.builtins.formatting.shfmt,
    nls.builtins.formatting.shfmt,
    nls.builtins.formatting.sqlfluff.with({
      extra_args = { "--dialect", "postgres" },
    }),
    nls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
    nls.builtins.formatting.swiftformat,
    nls.builtins.formatting.swiftlint,
    nls.builtins.formatting.taplo,
    nls.builtins.formatting.terraform_fmt,
    nls.builtins.formatting.yamlfmt,

    nls.builtins.code_actions.shellcheck,
    nls.builtins.code_actions.gitsigns,
  },
  on_attach = function(client, bufnr)
    vim.keymap.set(
      "n",
      "<leader>tF",
      "<cmd>lua require('core.plugins.lsp.utils').toggle_autoformat()<cr>",
      { desc = "Toggle format on save" }
    )
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          if AUTOFORMAT_ACTIVE then -- global var defined in functions.lua
            vim.lsp.buf.format({ bufnr = bufnr })
          end
        end,
      })
    end
  end,
})
