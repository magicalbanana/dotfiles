-- Turn off syntax highlighting for large YAML files.
if vim.fn.line('$') > 500 then
  vim.bo.syntax = 'OFF'
end

local vo = vim.opt_local
vo.tabstop = 2
vo.shiftwidth = 2
vo.softtabstop = 2
