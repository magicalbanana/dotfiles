" Turn off syntax highlighting for large YAML files.
setlocal wrap
if line('$') > 500
  setlocal syntax=OFF
endif
