" vimux golang
map <F1> :wa<CR> :GolangTestCurrentPackage<CR>
map <F2> :wa<CR> :GolangTestFocused<CR>

" benmills/vim-golang-alternate (original)
" Overrides vim's :A command to toggle between go
" implementation code and test code.
"
" usage :A will open the current file's tests or the current test's
" implementation based on what is currently opened.  :AS will act the same as :A
" but will move the current file to a new buffer in a split.  :AV will act the
" same as :AS but with a vertical split.

function! GolangGetAlternateFilename(filepath)
  let fileToOpen = ""

  if empty(matchstr(a:filepath, "_test"))
    let currentFileRoot = split(a:filepath, ".go$")[0]
    let fileToOpen = currentFileRoot . "_test.go"
  else
    let currentFileRoot = split(a:filepath, "_test.go$")[0]
    let fileToOpen = currentFileRoot . ".go"
  endif

  return fileToOpen
endfunction

function! GolangEditCommand(baseCommand)
    if a:baseCommand == "A"
      return "e"
    elseif a:baseCommand == "AS"
      return "sp"
    elseif a:baseCommand == "AV"
      return "vs"
    endif
endfunction

function! GolangAlternateFile(baseCommand)
  let currentFilePath = expand(bufname("%"))
  let fileToOpen = GolangGetAlternateFilename(currentFilePath)

  if filereadable(fileToOpen)
    exec(":" . GolangEditCommand(a:baseCommand). " " . fileToOpen)
  else
    echoerr "couldn't find file " . fileToOpen
  endif
endfunction

command! -buffer GoTA :call GolangAlternateFile("A")
command! -buffer GoTAV :call GolangAlternateFile("AV")
command! -buffer GoTAS :call GolangAlternateFile("AS")

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

nmap <silent> <leader>gi <Plug>(go-info)
nmap <silent> <leader>gI <Plug>(go-implements)
nmap <silent> <leader>gd <Plug>(go-describe)
nmap <silent> <leader>gc <Plug>(go-callers)
