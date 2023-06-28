return {
  Lua = {
    codeLens = { enable = true },
    hint = {
      enable = true,
      arrayIndex = "Disable",
      setType = false,
      paramName = "Disable",
      paramType = true,
    },
    format = { enable = false },
    diagnostics = {
      globals = { "vim" },
    },
    completion = { keywordSnippet = "Replace", callSnippet = "Replace" },
    workspace = { checkThirdParty = false },
    telemetry = { enable = false },
  },
}
