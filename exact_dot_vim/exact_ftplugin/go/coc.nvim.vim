let s:gopls_path = trim(system('go env GOBIN')).'/gopls'
if filereadable(s:gopls_path)
  call coc#config('go.goplsPath', s:gopls_path)
endif

