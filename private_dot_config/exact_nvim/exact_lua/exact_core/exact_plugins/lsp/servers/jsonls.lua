return {
  json = {
    settings = {
      schemas = require("schemastore").json.schemas({
        extra = {
          {
            name = "renovate-schema.json",
            description = "Renovate config",
            fileMatch = {
              "renovate.json",
              "renovate.json5",
              ".github/renovate.json",
              ".github/renovate.json5",
              ".renovaterc",
              ".renovaterc.json",
            },
            url = "https://docs.renovatebot.com/renovate-schema",
          },
        },
      }),
      format = { enabled = false },
      validate = { enable = true },
      completion = true,
      hover = true,
    },
  },
}
