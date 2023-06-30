--- This module will load a random colorscheme on nvim startup process.

local utils = require("core.utils.functions")

local M = {}

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.random = function()
  local colorschemes = {
    catppuccin = "catppuccin",
    doomone = "doom-one",
    kanagawa = "kanagawa",
    neon = "neon",
    nightfox = "nightfox",
    nord = "nord",
    nordic = "nordic",
    onenord = "onenord",
    tokyonight = "tokyonight",
    tundra = "tundra",
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

M.nordic = function()
  vim.cmd([[colorscheme nordic]])
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

M.tundra = function()
  vim.opt.background = "dark"

  vim.cmd(string.format("colorscheme %s", "tundra"))
end

M.neon = function()
  vim.cmd(string.format("colorscheme %s", "neon"))
end

M.doomone = function()
  vim.cmd(string.format("colorscheme %s", "doom-one"))
end

return M
