local api = vim.api
local fn = vim.fn

local runtime = os.getenv("VIMRUNTIME")

return {
  Lua = {
    telemetry = {
      enable = false,
    },
    runtime = {
        version = "LuaJIT",
    },
    workspace = {
      library = {
        fn.stdpath("config"),
        runtime .. '/lua',
        runtime,
      },
      checkThirdParty = false,
          maxPreload = 2000,
          preloadFileSize = 50000,
    },
    diagnostics = {
      globals = { "vim" },
    },
    codeLens = {
      enable = true,
    },
    hint = {
      enable = true,
      arrayIndex = "Disable",
      setType = false,
      paramName = "Disable",
      paramType = true,
    },
    format = {
      enable = false,
    },
    completion = {
      keywordSnippet = "Replace",
      callSnippet = "Replace",
    },
  },
}
