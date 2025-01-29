----------------------------------------------------------------------------------------------------
--  _____  ___    ___      ___
-- (\"   \|"  \  |"  \    /"  |
-- |.\\   \    |  \   \  //   |
-- |: \.   \\  |  /\\  \/.    |  neumachen's dotfiles
-- |.  \    \. | |: \.        |  https://gihtub.com/neumachen/dotfiles
-- |    \    \ | |.  \    /:  |
--  \___|\____\) |___|\__/|___|
--
----------------------------------------------------------------------------------------------------

local g, fn, opt, loop, env, cmd = vim.g, vim.fn, vim.opt, vim.uv, vim.env, vim.cmd

----------------------------------------------------------------------------------------------------
-- Leader bindings
----------------------------------------------------------------------------------------------------
g.mapleader = ',' -- Remap leader key
g.maplocalleader = ' ' -- Local leader is <Space>
----------------------------------------------------------------------------------------------------
g.os = loop.os_uname().sysname
g.open_command = g.os == 'Darwin' and 'open' or 'xdg-open'
g.dotfiles = env.DOTFILES_DIR
g.vim_dir = fn.expand('~/.config/nvim')
g.dev_workspace_root = env.DEV_WORKSPACE_ROOT
g.vcs_repositories_dir = env.VCS_REPOSITORIES_DIR
g.mein_wissen_path = env.MEIN_WISSEN_PATH

----------------------------------------------------------------------------------------------------
if vim.loader then vim.loader.enable() end

if vim.g.vscode then
  ----------------------------------------------------------------------------------------------------
  -- GUI
  ----------------------------------------------------------------------------------------------------
  require('as.vscode')
else
  ----------------------------------------------------------------------------------------------------
  -- Global namespace
  ----------------------------------------------------------------------------------------------------
  local namespace = {
    ui = {
      winbar = { enable = false },
      statuscolumn = { enable = true },
      statusline = { enable = true },
    },
    -- some vim mappings require a mixture of commandline commands and function calls
    -- this table is place to store lua functions to be called in those mappings
    mappings = { enable = true },
  }

  -- This table is a globally accessible store to facilitating accessing
  -- helper functions and variables throughout my config
  _G.as = as or namespace
  _G.map = vim.keymap.set
  _G.P = vim.print
  ----------------------------------------------------------------------------------------------------
  -- TUI
  ----------------------------------------------------------------------------------------------------
  -- Order matters here as globals needs to be instantiated first etc.
  require('as.globals')
  require('as.highlights')
  require('as.ui')
  require('as.settings')
end

----------------------------------------------------------------------------------------------------
g.border = not vim.g.vscode and g.border or 'single'
------------------------------------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------------------------------------
local data = fn.stdpath('data')
local lazypath = data .. '/lazy/lazy.nvim'
if not loop.fs_stat(lazypath) then
  fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
  vim.notify('Installed lazy.nvim')
end
opt.runtimepath:prepend(lazypath)
----------------------------------------------------------------------------------------------------
--  $NVIM
----------------------------------------------------------------------------------------------------
-- NOTE: this must happen after the lazy path is setup
-- If opening from inside neovim terminal then do not load other plugins
if env.NVIM then return require('lazy').setup({ { 'willothy/flatten.nvim', config = true } }) end
------------------------------------------------------------------------------------------------------
require('lazy').setup({
  spec = {
    { import = 'as.plugins', cond = function() return not vim.g.vscode end },
    { import = 'as.vscode.plugins', cond = function() return vim.g.vscode end },
  },
  defaults = { lazy = true },
  concurrency = vim.uv.available_parallelism() * 2,
  ui = { border = g.border },
  checker = {
    concurrency = 15,
    enabled = true,
    notify = true,
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
  performance = {
    rtp = {
      paths = { data .. '/site' },
      disabled_plugins = { 'netrw', 'netrwPlugin' },
    },
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { 'tokyonight-storm' },
  },
  pkg = {
    enabled = true,
    cache = vim.fn.stdpath('state') .. '/lazy/pkg-cache.lua',
    versions = true, -- Honor versions in pkg sources
    -- the first package source that is found for a plugin will be used.
    sources = {
      'lazy',
      'rockspec',
      'packspec',
    },
  },
  rocks = {
    root = vim.fn.stdpath('data') .. '/lazy-rocks',
    server = 'https://nvim-neorocks.github.io/rocks-binaries/',
  },
  dev = {
    path = g.vcs_repositories_dir,
    patterns = { 'github.com/neumachen' },
    fallback = true,
  },
})

------------------------------------------------------------------------------------------------------
-- Builtin Packages
------------------------------------------------------------------------------------------------------
-- cfilter plugin allows filtering down an existing quickfix list
cmd.packadd('cfilter')
if not vim.g.vscode then
  map('n', '<leader>pm', '<Cmd>Lazy<CR>', { desc = 'manage' })
  ------------------------------------------------------------------------------------------------------
  -- Colour Scheme {{{1
  ------------------------------------------------------------------------------------------------------
  vim.g.high_contrast_theme = false -- set to true for themes like github_dark or night-owl
  as.pcall('theme failed to load because', cmd.colorscheme, 'catppuccin-frappe')
end
