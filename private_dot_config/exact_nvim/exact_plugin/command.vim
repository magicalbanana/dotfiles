" Capture output from a command to register @m, to paste, press "mp
command! -nargs=1 -complete=command Redir call utils#CaptureCommandOutput(<q-args>)

" show current date and time in human readable format
command! -nargs=? Datetime echo utils#iso_time(<q-args>)

" Convert Markdown file to PDF
command! ToPDF call s:md_to_pdf()

function! s:md_to_pdf() abort
  " check if pandoc is installed
  if executable('pandoc') != 1
    echoerr "pandoc not found"
    return
  endif

  let l:md_path = expand("%:p")
  let l:pdf_path = fnamemodify(l:md_path, ":r") .. ".pdf"

  let l:header_path = stdpath('config') . '/resources/head.tex'

  let l:cmd = "pandoc --pdf-engine=xelatex --highlight-style=zenburn --table-of-content " .
        \ "--include-in-header=" . l:header_path . " -V fontsize=10pt -V colorlinks -V toccolor=NavyBlue " .
        \ "-V linkcolor=red -V urlcolor=teal -V filecolor=magenta -s " .
        \ l:md_path . " -o " . l:pdf_path

  if g:is_mac
    let l:cmd = l:cmd . '&& open ' . l:pdf_path
  endif

  if g:is_win
    let l:cmd = l:cmd . '&& start ' . l:pdf_path
  endif

  " echomsg l:cmd

  let l:id = jobstart(l:cmd)

  if l:id == 0 || l:id == -1
    echoerr "Error running command"
  endif
endfunction

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
function! GetVisualToReplace() range
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
vmap <leader>z <Esc>:%s/<c-r>=GetVisualToReplace()<cr>/
vmap <leader>Z <Esc>:%s/\<<c-r>=GetVisualToReplace()<cr>\>/
