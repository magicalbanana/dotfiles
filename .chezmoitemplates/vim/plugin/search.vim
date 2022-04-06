set incsearch  " do incremental searching
set hlsearch   " highlight search results
set ignorecase " make searching case insensitive
set smartcase  " ... unless the query has capital letters

" minus repeats fFtT search forward
noremap - ;

" underscore repeats fFtT search backward
noremap _ ,

" make <C-l> (redraw screen) also turn off
" search highlighting until the next search
" http://vim.wikia.com/wiki/Example_vimrc
nnoremap <silent> <C-l> :nohlsearch<Return><C-l>

" find merge conflict markers
nnoremap <Leader>c/ /^[<=>]\{7\}\( \<Bar>$\)/<Return>

" =============== Search and Replace Function ===============
" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
  vmap <leader>z <Esc>:%s/<c-r>=GetVisual()<cr>/
  vmap <leader>Z <Esc>:%s/\<<c-r>=GetVisual()<cr>\>/

" The Silver Searcher
" Inspired by http://robots.thoughtbot.com/faster-grepping-in-vim/
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --path-to-agignore\ $HOME/.agignore

  " " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  "
  " " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0

  " bind K to grep word under cursor
  nnoremap K <NOP>
  nnoremap <leader>K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " bind , (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

  " nnoremap , :Ag<SPACE>
endif

" no hightlight
nmap <F3> :noh<CR>
imap <F3> <esc>:noh<CR>
