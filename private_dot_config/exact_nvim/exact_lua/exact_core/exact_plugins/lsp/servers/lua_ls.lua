return {
  Lua = {
    cmd = { "lua-language-server" },
    format = {
      enable = false, -- let null-ls handle the formatting
    },
    filetypes = { "lua" },
    runtime = {
      version = "LuaJIT",
      path = vim.split(package.path, ";"),
    },
    completion = {
      enable = true,
      callSnippet = "Replace",
    },
    diagnostics = {
      globals = {
        "vim",
        "nnoremap",
        "vnoremap",
        "inoremap",
        "tnoremap",
        "use",
      },
    },
    workspace = {
      library = {
        vim.api.nvim_get_runtime_file("", true),
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
      },
      -- adjust these two values if your performance is not optimal
      maxPreload = 5000,
      preloadFileSize = 2000,
    },
    telemetry = { enable = false },
  },
}
