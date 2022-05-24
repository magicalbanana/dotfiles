let g:go_bin_path = trim(system('go env GOBIN'))
let g:go_gopls_options = ['-remote=auto', '-logfile=/tmp/gopls.log']

let g:go_auto_sameids = 0
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_echo_go_info = 0

let g:go_fmt_command = 'gopls'
let g:go_imports_autosave = 1
let g:go_fmt_autosave = 1
let g:gopls_gofumpt = 1

let g:go_diagnostics_enabled = 0
let g:go_metalinter_command = 'golangci-lint'
let g:go_metalinter_autosave = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_generate_tags = 1
