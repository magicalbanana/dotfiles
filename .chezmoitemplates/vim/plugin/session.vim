let s:session_loaded = 1

augroup autosession
  " load last session on start
  " Note: without 'nested' filetypes are not restored.
  autocmd VimEnter * nested call s:session_vim_enter()
  autocmd VimLeavePre * call s:session_vim_leave()
augroup END

function! s:session_vim_enter()
    if bufnr('$') == 1 && bufname('%') == '' && !&mod && getline(1, '$') == ['']
        execute 'silent source ~/.vim-last-session.vim'
    else
      let s:session_loaded = 0
    endif
endfunction

function! s:session_vim_leave()
  if s:session_loaded == 1
    let sessionoptions = &sessionoptions
    try
        set sessionoptions-=options
        set sessionoptions+=tabpages
        execute 'mksession! ~/.vim-last-session.vim'
    finally
        let &sessionoptions = sessionoptions
    endtry
  endif
endfunction
