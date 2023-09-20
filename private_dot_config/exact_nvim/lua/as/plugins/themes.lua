return {
  { 'akinsho/horizon.nvim', dev = true, lazy = false, priority = 1000 },
  { 'igorgue/danger', lazy = false },
  {
    'NTBBloodbath/doom-one.nvim',
    lazy = false,
    config = function()
      vim.g.doom_one_pumblend_enable = true
      vim.g.doom_one_pumblend_transparency = 3
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        -- borderless telescope
        on_highlights = function(hl, c)
          local prompt = "#2d3149"
          hl.telescopenormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
          }
          hl.telescopeborder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.telescopepromptnormal = {
            bg = prompt,
          }
          hl.telescopepromptborder = {
            bg = prompt,
            fg = prompt,
          }
          hl.telescopeprompttitle = {
            bg = prompt,
            fg = prompt,
          }
          hl.telescopepreviewtitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.telescoperesultstitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
        end,
      })
    end,
  }
}
