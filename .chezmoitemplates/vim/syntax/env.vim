if exists("b:current_syntax")
  finish
endif

syn keyword envKeyword contained export
syn match envVariable /^\zs.\{-}\ze=/
syn match envOperator /\(.*=.*\)\@<!=/

hi def link envKeyword Keyword
hi def link envVariable Identifier
hi def link envOperator Operator

let b:current_syntax = "env"
