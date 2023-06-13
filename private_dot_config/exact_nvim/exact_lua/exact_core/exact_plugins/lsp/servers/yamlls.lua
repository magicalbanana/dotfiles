return {
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
      },
      schemas = {
        schemas = require("schemastore").yaml.schemas(),
      },
      format = { enabled = false },
      validate = { enable = true },
      completion = true,
      hover = true,
    },
  },
}
