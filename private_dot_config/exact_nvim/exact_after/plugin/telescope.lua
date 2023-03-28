local telescope = require("telescope")

telescope.load_extension("node_modules")
telescope.load_extension("fzf")

local builtin = require('telescope.builtin')
local keymap = vim.keymap

keymap.set('n', '<leader>tf', builtin.find_files, {})
keymap.set('n', '<leader>tg', builtin.live_grep, {})
keymap.set('n', '<leader>tt', builtin.help_tags, {})
keymap.set('n', '<leader>tu', builtin.buffers, {})
keymap.set('n', '<leader>ts', builtin.git_status, {})
