" disable ALE
" au BufEnter *.rb :call ale#toggle#DisableBuffer(bufnr(''))

" setlocal complete-=i
" setlocal synmaxcol=120 " don't syntax highlight very long lines
" setlocal foldmethod=syntax

iabbrev <buffer> pry! require 'pry'; binding.pry
iabbrev <buffer> bpry! binding.pry

map <Leader>rt :! ctags --extra=+f --exclude=.git --exclude=log -R * gem environment gemdir/gems/*<CR><CR>
" map <silent> <Leader>rT :!$(bundle list --paths=true | xargs ctags --extra=+f --exclude=.git --exclude=log -R *)<CR><CR>
