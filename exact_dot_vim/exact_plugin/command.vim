set shell=$SHELL  " use $SHELL for command substitution
set history=10000 " remember this many commands and searches
set confirm       " ask user before aborting an action
set wildmenu      " tab-completion menu for command mode
set wildmode=list:longest,full

" colonless entrance into command mode
noremap ; :
noremap ! :!

" colonless replaying of recent command
noremap @; @:
noremap @! :!<Up><Return>
