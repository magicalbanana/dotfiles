let g:ale_enabled = 0

let g:ale_pattern_options = {
\ '\.rb$': {'ale_enabled': 1},
\ '\.erb$': {'ale_enabled': 1},
\ '\.slim$': {'ale_enabled': 1},
\ '\.rake$': {'ale_enabled': 1},
\}
" If you configure g:ale_pattern_options outside of vimrc, you need this.
let g:ale_pattern_options_enabled = 1
