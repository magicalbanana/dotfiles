-- Load global functions
require("core.globals")
-- Plugin management via lazy
require("core.lazy")
-- "Global" Keymappings
require("core.mappings")
-- All non plugin related (vim) options
require("core.options")
-- Vim autocommands/autogroups
require("core.autocommands")

local colorschemes = require("core.utils.colorschemes")
colorschemes.random()
