" share yanks across the terminals
set clipboard=unnamed,unnamedplus

" be consistent with C and D which reach the end of line
nnoremap Y y$

" copy the current text selection to the system clipboard
if has('gui_running')
  noremap <Leader>y "+y
else
  " copy to attached terminal using the yank(1) script:
  " https://github.com/sunaku/home/blob/master/bin/yank
  noremap <silent> <Leader>y y:call system('yank', @0)<Return>
endif

" https://wiki.vifm.info/index.php/How_to_copy_path_to_current_file/directory_to_system_clipboard
" yank current directory path into the clipboard
" nnoremap yd :!echo -n %d | xclip -selection clipboard %i<cr>:echo expand('%"d') "is yanked to clipboard"<cr>
"
" " yank current file path into the clipboard
" nnoremap yf :!echo -n %c:p | xclip -selection clipboard %i<cr>:echo expand('%"c:p') "is yanked to clipboard"<cr>
"
" " yank current filename without path into the clipboard
" nnoremap yn :!echo -n %c | xclip -selection clipboard %i<cr>:echo expand('%"c') "is yanked to clipboard"<cr>
"
" " yank root of current file's name into the clipboard
" nnoremap yr :!echo -n %c:r | xclip -selection clipboard %i<cr>:echo expand('%"c:r') "is yanked to clipboard"<cr>

" https://stackoverflow.com/a/17096082
" copy current file name (relative/absolute) to system clipboard
if has("mac") || has("gui_macvim") || has("gui_mac")
  " relative path  (src/foo.txt)
  nnoremap <leader>cf :let @*=expand("%")<CR>

  " absolute path  (/something/src/foo.txt)
  nnoremap <leader>cF :let @*=expand("%:p")<CR>

  " filename       (foo.txt)
  nnoremap <leader>ct :let @*=expand("%:t")<CR>

  " directory name (/something/src)
  nnoremap <leader>ch :let @*=expand("%:p:h")<CR>
endif

" copy current file name (relative/absolute) to system clipboard (Linux version)
if has("gui_gtk") || has("gui_gtk2") || has("gui_gnome") || has("unix")
  " relative path (src/foo.txt)
  nnoremap <leader>cf :let @+=expand("%")<Return>

  " absolute path (/something/src/foo.txt)
  nnoremap <leader>cF :let @+=expand("%:p")<Return>

  " filename (foo.txt)
  nnoremap <leader>ct :let @+=expand("%:t")<Return>

  " directory name (/something/src)
  nnoremap <leader>ch :let @+=expand("%:p:h")<Return>
endif
