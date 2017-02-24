colorscheme pablo

highlight CursorLine gui=NONE guibg=Grey40 guifg=NONE
highlight ColorColumn gui=NONE guibg=Grey40 guifg=NONE

if filereadable($MYGVIMRC . '.local')
	source $MYGVIMRC.local
endif
