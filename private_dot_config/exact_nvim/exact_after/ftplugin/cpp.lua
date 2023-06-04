-- Set commentstring to "// %s"
vim.bo.commentstring = "// %s"

-- Disable inserting comment leader after hitting o or O or <Enter>
vim.opt.formatoptions:remove("o")
vim.opt.formatoptions:remove("r")

-- Key mapping for calling compile_run_cpp()
vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':call v:lua._compile_run_cpp()<CR>', { silent = true })

-- Function for compiling and running C++ code
function _compile_run_cpp()
  local src_path = vim.fn.expand('%:p:~')
  local src_noext = vim.fn.expand('%:p:~:r')
  -- The building flags
  local _flag = '-Wall -Wextra -std=c++11 -O2'

  local prog
  if vim.fn.executable('clang++') == 1 then
    prog = 'clang++'
  elseif vim.fn.executable('g++') == 1 then
    prog = 'g++'
  else
    printerr('No C++ compiler found on the system!')
    return
  end

  _create_term_buf('h', 20)
  vim.cmd(string.format('term %s %s %s -o %s && %s', prog, _flag, src_path, src_noext, src_noext))
  vim.cmd('startinsert')
end

-- Function for creating a terminal buffer
function _create_term_buf(_type, size)
  vim.opt.splitbelow = true
  vim.opt.splitright = true
  if _type == 'v' then
    vim.cmd('vnew')
  else
    vim.cmd('new')
  end
  vim.cmd('resize ' .. size)
end

-- Set delimitMate_matchpairs for delimitMate plugin
vim.g.delimitMate_matchpairs = '(:),[:],{:}'
