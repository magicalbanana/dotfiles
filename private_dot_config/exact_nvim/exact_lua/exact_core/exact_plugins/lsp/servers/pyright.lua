local utils = require("core.plugins.lsp.utils")

return {
  before_init = function(_, config)
    if lsp == "pyright" then
      config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
    end
  end,
}
