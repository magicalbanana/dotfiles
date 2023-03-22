--- This module will load a random colorscheme on nvim startup process.

local utils = require("utils")

local M = {}

-- Colorscheme to its directory name mapping, because colorscheme repo name is not necessarily
-- the same as the colorscheme name itself.
M.colorscheme2dir = {
  catppuccin = "catppuccin",
  gruvbox_material = "gruvbox-material",
  kanagawa = "kanagawa.nvim",
  material = "material.nvim",
  monokai = "monokai.nvim",
  nightfox = "nightfox.nvim",
  nord = "nord.nvim",
  onedark = "onedark.nvim",
  onedarkpro = "onedarkpro.nvim",
  oxocarbon = "oxocarbon.nvim",
  rose_pine = "rose-pine",
  sonokai = "sonokai",
  tokyonight = "tokyonight",
  zephyr = "zephyr-nvim",
}

M.gruvbox8 = function()
  -- Italic options should be put before colorscheme setting,
  -- see https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
  vim.g.gruvbox_italics = 1
  vim.g.gruvbox_italicize_strings = 1
  vim.g.gruvbox_filetype_hi_groups = 1
  vim.g.gruvbox_plugin_hi_groups = 1

  vim.cmd([[colorscheme gruvbox8_hard]])
end

M.onedark = function()
  vim.cmd([[colorscheme onedark]])
end

M.oxocarbon = function()
  vim.opt.background = "dark"
  vim.cmd([[colorscheme oxocarbon]])
end

M.zephyr = function()
  vim.cmd([[colorscheme zephyr]])
end

M.sonokai = function()
  vim.g.sonokai_enable_italic = 1
  vim.g.sonokai_better_performance = 1

  vim.cmd([[colorscheme sonokai]])
end

M.gruvbox_material = function()
  -- foreground option can be material, mix, or original
  vim.g.gruvbox_material_foreground = "material"
  --background option can be hard, medium, soft
  vim.g.gruvbox_material_background = "soft"
  vim.g.gruvbox_material_enable_italic = 1
  vim.g.gruvbox_material_better_performance = 1

  vim.cmd([[colorscheme gruvbox-material]])
end

M.nord = function()
  vim.g.nord_contrast = true
  vim.g.nord_borders = false
  vim.g.nord_disable_background = false
  vim.g.nord_italic = false
  vim.g.nord_uniform_diff_background = true
  vim.g.nord_bold = false

  vim.cmd([[colorscheme nord]])
end

M.doom_one = function()
  vim.cmd([[colorscheme doom-one]])
end

M.everforest = function()
  vim.g.everforest_enable_italic = 1
  vim.g.everforest_better_performance = 1

  vim.cmd([[colorscheme everforest]])
end

M.nightfox = function()
  local themes = {
    "nightfox",
    "dayfox",
    "dawnfox",
    "duskfox",
    "nordfox",
    "terafox",
    "carbonfox",
  }

  local theme = utils.rand_element(vim.tbl_keys(themes))
  vim.cmd(string.format("colorscheme %s", themes[theme]))
end

M.kanagawa = function()
  local themes = {
    "kanagawa-wave",
    "kanagawa-dragon",
    "kanagawa-lotus",
  }

  local theme = utils.rand_element(vim.tbl_keys(themes))
  vim.cmd(string.format("colorscheme %s", themes[theme]))
end

M.tokyonight = function()
  local themes = {
    "tokyonight-night",
    "tokyonight-storm",
    "tokyonight-day",
    "tokyonight-moon",
  }

  local theme = utils.rand_element(vim.tbl_keys(themes))
  vim.cmd(string.format("colorscheme %s", themes[theme]))
end

M.catppuccin = function()
  -- available option: latte, frappe, macchiato, mocha
  vim.g.catppuccin_flavour = "frappe"

  require("catppuccin").setup()

  vim.cmd([[colorscheme catppuccin]])
end

M.rose_pine = function()
  require('rose-pine').setup({
    --- @usage 'main' | 'moon'
    dark_variant = 'moon',
  })

  -- set colorscheme after options
  vim.cmd('colorscheme rose-pine')
end

M.onedarkpro = function()
  -- set colorscheme after options
  vim.cmd('colorscheme onedark_vivid')
end

M.monokai = function()
  vim.cmd('colorscheme monokai_pro')
end

M.material = function ()
  vim.g.material_style = "oceanic"
  vim.cmd('colorscheme material')
end

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.rand_colorscheme = function()
  local colorscheme = utils.rand_element(vim.tbl_keys(M.colorscheme2dir))

  if not vim.tbl_contains(vim.tbl_keys(M), colorscheme) then
    local msg = "Invalid colorscheme: " .. colorscheme
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })

    return
  end

  -- Load the colorscheme, because all the colorschemes are declared as opt plugins, so the colorscheme isn't loaded yet.
  local status = utils.add_pack(M.colorscheme2dir[colorscheme])

  if not status then
    local msg = string.format("Colorscheme %s is not installed. Run PackerSync to install.", colorscheme)
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })

    return
  end

  -- Load the colorscheme and its settings
  M[colorscheme]()

  if vim.g.logging_level == "debug" then
    local msg = "Colorscheme: " .. colorscheme

    vim.notify(msg, vim.log.levels.DEBUG, { title = "nvim-config" })
  end
end

-- Load a random colorscheme
M.rand_colorscheme()
