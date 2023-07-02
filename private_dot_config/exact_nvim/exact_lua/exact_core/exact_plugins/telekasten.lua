local mein_wissen_path = os.getenv("MEIN_WISSEN_PATH")
if mein_wissen_path == nil or mein_wissen_path == "" then
  return {}
end

return {
  "renerocksai/telekasten.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "iamcco/markdown-preview.nvim",
  },
  config = function()
    require("telekasten").setup({
      home = mein_wissen_path,
      take_over_my_home = false,
      auto_set_filetype = false,
      auto_set_syntax = true,
      install_syntax = true,
    })
  end,
}
