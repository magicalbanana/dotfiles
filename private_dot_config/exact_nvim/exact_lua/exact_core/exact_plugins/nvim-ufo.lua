local fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return {
  "kevinhwang91/nvim-ufo",
  event = "VeryLazy",
  dependencies = { "kevinhwang91/promise-async" },
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      "open all folds",
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      "close all folds",
    },
    {
      "zP",
      function()
        require("ufo").peekFoldedLinesUnderCursor()
      end,
      "preview fold",
    },
  },
  opts = function()
    local ft_map = { rust = "lsp" }

    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    require("ufo").setup({
      open_fold_hl_timeout = 0,
      preview = { win_config = { winhighlight = "Normal:Normal,FloatBorder:Normal" } },
      enable_get_fold_virt_text = true,
      close_fold_kinds = { "imports", "comment" },
      provider_selector = function(_, ft)
        return ft_map[ft] or { "treesitter", "indent" }
      end,
      fold_virt_text_handler = fold_virt_text_handler,
    })
  end,
}
