local telescope = require("telescope")

telescope.load_extension("node_modules")
telescope.load_extension("fzf")

local builtin = require('telescope.builtin')
local keymap = vim.keymap

keymap.set('n', '<space>ff', builtin.find_files, {})
keymap.set('n', '<space>lg', builtin.live_grep, {})
keymap.set('n', '<space>ht', builtin.help_tags, {})
keymap.set('n', '<space>bs', builtin.buffers, {})
keymap.set('n', '<space>gs', builtin.git_status, {})
