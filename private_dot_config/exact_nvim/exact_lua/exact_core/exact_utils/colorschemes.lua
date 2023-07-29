--- This module will load a random colorscheme on nvim startup process.

local utils = require("core.utils.functions")

local M = {}

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.random = function()
  local colorschemes = {
    catppuccin = "catppuccin",
    kanagawa = "kanagawa",
    nightfox = "nightfox",
    nord = "nord",
    onenord = "onenord",
    tokyonight = "tokyonight",
  }
  local colorscheme = utils.rand_element(vim.tbl_keys(colorschemes))

  -- Load the colorscheme and its settings
  M[colorscheme]()
  local msg = "colorscheme: " .. colorscheme

  vim.notify(msg, vim.log.levels.INFO, { title = "nvim-config" })
end

M.catppuccin = function()
  local themes = {
    "catppuccin-frappe",
    "catppuccin-macchiato",
  }

  local theme = utils.rand_element(vim.tbl_keys(themes))
  vim.cmd(string.format("colorscheme %s", themes[theme]))
end

M.nord = function()
  vim.cmd([[colorscheme nord]])
end

M.onenord = function()
  vim.cmd([[colorscheme onenord]])
end

M.nightfox = function()
  local themes = {
    "nightfox",
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
  }
  colorscheme
  local theme = utils.rand_element(vim.tbl_keys(themes))
  vim.cmd(string.format("colorscheme %s", themes[theme]))
end

M.tokyonight = function()
  local themes = {
    "tokyonight-night",
    "tokyonight-storm",
    "tokyonight-moon",
  }

  local theme = utils.rand_element(vim.tbl_keys(themes))
  vim.cmd(string.format("colorscheme %s", themes[theme]))
end

return M
