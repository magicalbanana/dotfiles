local utils = require("core.utils.functions")
local map = vim.keymap.set

-- Save key strokes (now we do not need to press shift to enter command mode).
map({ "n", "x" }, ";", ":")

-- Do not include white space characters when using $ in visual mode,
-- see https://vi.stackexchange.com/q/12607/15292
map("x", "$", "g_")

-- Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

-- switch buffer
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })

-- Cancel search highlighting with ESC
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch and ESC" })

-- move over a closing element in insert mode
map("i", "<C-l>", function()
  return require("core.utils.functions").escapePair()
end)

-- Paste non-linewise text above or below current line, see https://stackoverflow.com/a/1346777/6064933
map("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line" })
map("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line" })

-- toggles
map("n", "<leader>th", function()
  utils.notify("Toggling hidden chars", vim.log.levels.INFO, "core.mappings")
  vim.o.list = vim.o.list == false and true or false
end, { desc = "Toggle hidden chars" })
map("n", "<leader>tl", function()
  utils.notify("Toggling signcolumn", vim.log.levels.INFO, "core.mappings")
  vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
end, { desc = "Toggle signcolumn" })
map("n", "<leader>tv", function()
  utils.notify("Toggling virtualedit", vim.log.levels.INFO, "core.mappings")
  vim.o.virtualedit = vim.o.virtualedit == "all" and "block" or "all"
end, { desc = "Toggle virtualedit" })
map("n", "<leader>ts", function()
  utils.notify("Toggling spell", vim.log.levels.INFO, "core.mappings")
  vim.o.spell = vim.o.spell == false and true or false
end, { desc = "Toggle spell" })
map("n", "<leader>tw", function()
  utils.notify("Toggling wrap", vim.log.levels.INFO, "core.mappings")
  vim.o.wrap = vim.o.wrap == false and true or false
end, { desc = "Toggle wrap" })
map("n", "<leader>tc", function()
  utils.notify("Toggling cursorline", vim.log.levels.INFO, "core.mappings")
  vim.o.cursorline = vim.o.cursorline == false and true or false
end, { desc = "Toggle cursorline" })
map(
  "n",
  "<leader>to",
  "<cmd>lua require('core.utils.functions').toggle_colorcolumn()<cr>",
  { desc = "Toggle colorcolumn" }
)
map(
  "n",
  "<leader>tt",
  "<cmd>lua require('core.plugins.lsp.utils').toggle_virtual_text()<cr>",
  { desc = "Toggle Virtualtext" }
)
map("n", "<leader>ts", "<cmd>SymbolsOutline<cr>", { desc = "Toggle SymbolsOutline" })

-- Edit and reload nvim config file quickly
map("n", "<leader>ev", "<cmd>tabnew $MYVIMRC <bar> tcd %:h<cr>", {
  silent = true,
  desc = "open init.lua",
})

map("n", "<leader>sv", function()
  vim.cmd([[
      update $MYVIMRC
      source $MYVIMRC
    ]])
  vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
end, {
  silent = true,
  desc = "reload init.lua",
})

map("n", "gb", "<cmd>BufferLinePick<cr>", {
  silent = true,
  desc = "Pick buffer",
})

map("n", "gD", "<cmd>BufferLinePickClose<cr>", {
  silent = true,
  desc = "Close buffer",
})

local wk = require("which-key")

-- register non leader based mappings
wk.register({
  s = "Initiate Leap (search) forward",
  S = "Initiate Leap (search) backwards",
  sa = "Add surrounding",
  sd = "Delete surrounding",
  sh = "Highlight surrounding",
  sn = "Surround update n lines",
  sr = "Replace surrounding",
  sF = "Find left surrounding",
  sf = "Replace right surrounding",
  st = { "<cmd>lua require('tsht').nodes()<cr>", "TS hint textobject" },
  gb = "Pick buffer",
  gD = "Close buffer",
})

-- Register leader based mappings
wk.register({
  ["<tab>"] = { "<cmd>e#<cr>", "Prev buffer" },
  b = {
    name = "Buffers",
    D = {
      "<cmd>%bd|e#|bd#<cr>",
      "Close all but the current buffer",
    },
    d = { "<cmd>Bdelete<cr>", "Close buffer" },
  },
  l = { "LSP" }, -- core.plugins.lsp.keys
  lw = { "Workspaces" }, -- core.plugins.lsp.keys
  f = {
    name = "Files",
    s = { "<cmd>w<cr>", "Save Buffer" },
  },
  m = {
    name = "Misc",
    C = { "<cmd>:CBcatalog<cr>", "Commentbox Catalog" },
    l = { "<cmd>source ~/.config/nvim/snippets/*<cr>", "Reload snippets" },
    p = { "<cmd>Lazy check<cr>", "Lazy check" },
  },
  q = {
    name = "Quickfix",
    j = { "<cmd>cnext<cr>", "Next Quickfix Item" },
    k = { "<cmd>cprevious<cr>", "Previous Quickfix Item" },
    q = { "<cmd>lua require('core.utils.functions').toggle_qf()<cr>", "Toggle quickfix list" },
    t = { "<cmd>TodoQuickFix<cr>", "Show TODOs" },
  },
  t = { name = "Toggles" },
}, { prefix = "<leader>", mode = "n", {} })
