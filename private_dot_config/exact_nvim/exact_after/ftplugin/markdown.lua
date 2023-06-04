-- Set concealcursor to 'c'
vim.o.concealcursor = 'c'
-- Set synmaxcol to 3000
vim.o.synmaxcol = 3000
-- Enable text wrapping
vim.o.wrap = true

-- Fix minor issue with footnote
if vim.fn.exists(':FootnoteNumber') == 1 then
  vim.api.nvim_buf_set_keymap(0, 'n', '^^', ':<C-U>call markdownfootnotes#VimFootnotes(\'i\')<CR>', { silent = true })
  vim.api.nvim_buf_set_keymap(0, 'i', '^^', '<C-O>:<C-U>call markdownfootnotes#VimFootnotes(\'i\')<CR>', { silent = true })
  vim.api.nvim_buf_set_keymap(0, 'i', '@@', '<Plug>ReturnFromFootnote', {})
  vim.api.nvim_buf_set_keymap(0, 'n', '@@', '<Plug>ReturnFromFootnote', {})
end

-- Text objects for Markdown code blocks
vim.api.nvim_buf_set_keymap(0, 'x', 'ic', ':<C-U>call text_obj#MdCodeBlock(\'i\')<CR>', { silent = true })
vim.api.nvim_buf_set_keymap(0, 'x', 'ac', ':<C-U>call text_obj#MdCodeBlock(\'a\')<CR>', { silent = true })
vim.api.nvim_buf_set_keymap(0, 'o', 'ic', ':<C-U>call text_obj#MdCodeBlock(\'i\')<CR>', { silent = true })
vim.api.nvim_buf_set_keymap(0, 'o', 'ac', ':<C-U>call text_obj#MdCodeBlock(\'a\')<CR>', { silent = true })

-- Use + to turn several lines to an unordered list
vim.api.nvim_buf_set_keymap(0, 'n', '+', ':set operatorfunc=AddListSymbol<CR>g@', { silent = true })
vim.api.nvim_buf_set_keymap(0, 'x', '+', ':<C-U>call AddListSymbol(v:lua.visualmode(), 1)<CR>', { silent = true })

function AddListSymbol(type, ...)
  local line_start, line_end
  if select('#', ...) > 0 then
    line_start = vim.fn.line("'<")
    line_end = vim.fn.line("'>")
  else
    line_start = vim.fn.line("'[")
    line_end = vim.fn.line("']")
  end

  for line = line_start, line_end do
    local text = vim.fn.getline(line)
    local _, end_col = text:find('^%s*')

    local new_text
    if end_col == 1 then
      new_text = '+ ' .. text
    else
      new_text = text:sub(1, end_col - 1) .. ' + ' .. text:sub(end_col)
    end

    vim.fn.setline(line, new_text)
  end
end

-- Add hard line breaks for Markdown
vim.api.nvim_buf_set_keymap(0, 'n', '\\', ':set operatorfunc=AddLineBreak<CR>g@', { silent = true })
vim.api.nvim_buf_set_keymap(0, 'x', '\\', ':<C-U>call AddLineBreak(v:lua.visualmode(), 1)<CR>', { silent = true })

function AddLineBreak(type, ...)
  local line_start, line_end
  if select('#', ...) > 0 then
    line_start = vim.fn.line("'<")
    line_end = vim.fn.line("'>")
  else
    line_start = vim.fn.line("'[")
    line_end = vim.fn.line("']")
  end

  for line = line_start, line_end do
    local text = vim.fn.getline(line)
    local new_text = text .. "\\"

    vim.fn.setline(line, new_text)
  end
end
