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

if vim.g.vscode then return end -- if someone has forced me to use vscode don't load my config

local g, fn, env, cmd = vim.g, vim.fn, vim.env, vim.cmd
local data = fn.stdpath('data')

if vim.loader then vim.loader.enable() end

g.os = vim.loop.os_uname().sysname
g.open_command = g.os == 'Darwin' and 'open' or 'xdg-open'

g.dotfiles = env.DOTFILES_DIR
g.vim_dir = fn.expand('~/.config/nvim')
g.dev_workspace_root = env.DEV_WORKSPACE_ROOT
g.vcs_repositories_dir = env.VCS_REPOSITORIES_DIR
g.mein_wissen_path = env.MEIN_WISSEN_PATH
----------------------------------------------------------------------------------------------------
-- Leader bindings
----------------------------------------------------------------------------------------------------
g.mapleader = ',' -- Remap leader key
g.maplocalleader = ' ' -- Local leader is <Space>
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
-- Settings
----------------------------------------------------------------------------------------------------
-- Order matters here as globals needs to be instantiated first etc.
require('as.globals')
require('as.highlights')
require('as.ui')
require('as.settings')
------------------------------------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------------------------------------
local lazypath = data .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
----------------------------------------------------------------------------------------------------
--  $NVIM
----------------------------------------------------------------------------------------------------
-- NOTE: this must happen after the lazy path is setup

-- If opening from inside neovim terminal then do not load other plugins
if env.NVIM then return require('lazy').setup({ { 'willothy/flatten.nvim', config = true } }) end
------------------------------------------------------------------------------------------------------
require('lazy').setup({
  spec = {
    { import = 'as.plugins' },
  },
  concurrency = vim.uv.available_parallelism() * 2,
  ui = { border = as.ui.current.border },
  defaults = { lazy = true },
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

map('n', '<leader>pm', '<Cmd>Lazy<CR>', { desc = 'manage' })
------------------------------------------------------------------------------------------------------
-- Builtin Packages
------------------------------------------------------------------------------------------------------
-- cfilter plugin allows filtering down an existing quickfix list
cmd.packadd('cfilter')
------------------------------------------------------------------------------------------------------
-- Colour Scheme {{{1
------------------------------------------------------------------------------------------------------
as.pcall('theme failed to load because', cmd.colorscheme, 'tokyonight-storm') -- night-owl
