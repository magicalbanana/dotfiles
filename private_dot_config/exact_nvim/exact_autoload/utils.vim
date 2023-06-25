" Redirect command output to a register for later processing.
" Ref: https://stackoverflow.com/q/2573021/6064933 and https://unix.stackexchange.com/q/8101/221410 .
function! utils#CaptureCommandOutput(command) abort
  let l:tmp = @m
  redir @m
  silent! execute a:command
  redir END

  "create a scratch buffer for dumping the text, ref: https://vi.stackexchange.com/a/11311/15292.
  tabnew | setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile

  let l:lines = split(@m, '\n')
  call nvim_buf_set_lines(0, 0, 0, 0, l:lines)

  let @m = l:tmp
endfunction
