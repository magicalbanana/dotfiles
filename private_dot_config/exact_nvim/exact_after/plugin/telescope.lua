local telescope = require("telescope")

telescope.load_extension("node_modules")
telescope.load_extension("fzf")
telescope.load_extension("file_browser")

local builtin = require('telescope.builtin')
local keymap = vim.keymap

keymap.set('n', '<space>ff', builtin.find_files, {})
keymap.set('n', '<space>lg', builtin.live_grep, {})
keymap.set('n', '<space>ht', builtin.help_tags, {})
keymap.set('n', '<space>bs', builtin.buffers, {})
keymap.set('n', '<space>gs', builtin.git_status, {})

-- Open from the project directory
vim.api.nvim_set_keymap(
  "n",
  "<space>pd",
  ":Telescope file_browser",
  { noremap = true }
)

-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
  "n",
  "<space>fb",
  ":Telescope file_browser path=%:p:h select_buffer=true",
  { noremap = true }
)
