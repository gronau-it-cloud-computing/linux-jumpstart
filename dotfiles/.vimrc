" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif

" Turn off vi compatibility. Come on.
set nocompatible

" Automagical syntax highlighting
if has("syntax")
	syntax on
endif

" Automagical filetype autoindentation
if has("autocmd")
	filetype plugin indent on
endif

" Automagically open, but do not go to, the quickfix window
" and close it when it becomes empty
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

""" Miscellaneous options
let $PAGER=''											" Set PAGER for man viewing
set autoindent											" Turn on auto-indent
set autowrite											" Automagically save before some commands
set background=dark										" Look nice on a dark background
set backspace=indent,eol,start							" backspace over everything
set colorcolumn=80										" Colorize column 80
set cursorline											" Highlight current line
set diffopt=filler,vertical								" Keep files aligned, default to vsplit
set fileformats=unix,dos								" Automagically detect format by EOL
set hidden												" Keeps abandoned buffers loaded. Beware!
set nohlsearch											" Do not highlight every match
set noincsearch											" Do not search incrementally
set lazyredraw											" Don't redraw while executing macros
set listchars=tab:>-,trail:~,nbsp:.						" Show tabs, trailing spaces, and nbsp
set listchars+=eol:$,extends:>,precedes:<				" Show EOL, mark long (unwrapped) lines
set nomodeline											" Modelines be dangerous
set nrformats=alpha,octal,hex							" {in,de}crementing of alpha, octal, hex
set number												" Show line numbers
set shiftwidth=4										" Make shift width four spaces
set showcmd												" Show command in status line
set showmatch											" Show matching brackets
set splitright											" Open vertical splits on the right
set tabstop=4											" Make tab four spaces
set wildignore+=*.pyc,*.class,*.o						" Ignore these things in tab completion
set wildmode=longest,list								" Make tab-completion act like the shell's
""" END Miscellanea

""" Session Settings
set sessionoptions=buffers								" Save hidden, unloaded buffers in session
set ssop+=help											" Save the help window(s)
set ssop+=localoptions									" Keep any local options or mappings
set ssop+=resize										" Size of the Window: 'lines' and 'columns'
set ssop+=slash											" Replace back with fack in session file
set ssop+=tabpages										" Store all tabs in session
set ssop+=unix											" Use Unix line endings for session file
set ssop+=winpos										" Position of the Vim Window
set ssop+=winsize										" Size of each window
""" END Session Settings

""" Status Line
set laststatus=2										" Always show status line
set statusline=%4.4([%02.2n]%)\ 						" Show the buffer number
set stl+=%-35.35f\ 										" Filename (with relative path, or as typed)
set stl+=%-7.7([%{&ff}]%)								" File format
set stl+=%-15.15([%{''.(&fenc!=''?&fenc:&enc).''}]%)	" Encoding
set stl+=%6.6{FileSize()}								" File size
set stl+=%4.4(%4.4m%)									" Modified flag
set stl+=%4.4(%4.4r%)									" Readonly flag
set stl+=%-7.7(%{(&bomb?\"[BOM]\":\"\")}%)				" Byte-order mark flag
set stl+=%=												" Left/Right division point
set stl+=%-8.8(0x%04B%)									" Show value of byte under cursor in hex
set stl+=LN\ %l/%L\ 									" Line number
set stl+=COL\ %-8(%c%V%)								" Column number
set stl+=%P												" Percentage through file
""" END Status Line

""" Highlighting
highlight CursorLine cterm=NONE ctermbg=DarkGrey ctermfg=NONE
highlight ColorColumn cterm=NONE ctermbg=DarkGrey ctermfg=NONE
""" END Highlighting

""" Plugins
call plug#begin('~/.vim/plugged')
	Plug 'luochen1990/rainbow'
	Plug 'sluidfoe/vim-man'
call plug#end()
"" Rainbow Parens
let g:rainbow_active = 1
"" END Rainbow Parens
""" END Plugin

""" Keybindings
"" Buffer, window, and tab movement
" Bind C-<Direction> to move windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Bind <leader>-<Direction> to move tabs
nnoremap <leader>h gT
nnoremap <leader>l gt
" And <leader>-<Shift>-<Direction> to first/last tab
nnoremap <silent> <leader>H :tabfirst<CR>
nnoremap <silent> <leader>L :tablast<CR>

" Next/Previous buffer
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
"" END buffer/window/tab movement

"" Editing keybindings
" Delete for real
noremap <leader>d "_d
noremap <leader>D "_D

" Make Y act like you'd expect it to
noremap Y y$

" Some shortcuts for system clipboards
noremap <leader>p "+p
noremap <leader>P "*p
noremap <leader>y "+y
noremap <leader>Y "*y
"" END editing keybindings

"" Command line keybindings
" Set up default readline-style movement for command line
cnoremap <C-a>	<Home>
cnoremap <C-e>	<End>
cnoremap <Esc>b	<S-Left>
cnoremap <Esc>f	<S-Right>

" Bind :w!! to WRITE WITH EXTREME PREJUDICE
cnoremap w!! w !sudo tee % >/dev/null
"" END command line keybindings

" Disable arrow keys everywhere but command mode
noremap		<LEFT>	<NOP>
noremap		<DOWN>	<NOP>
noremap		<RIGHT>	<NOP>
noremap		<UP>	<NOP>
inoremap	<LEFT>	<NOP>
inoremap	<DOWN>	<NOP>
inoremap	<RIGHT>	<NOP>
inoremap	<UP>	<NOP>

" Bind F2 to toggle spellcheck
noremap <F2> :setlocal spelllang=en_us spell! spell?<CR>
inoremap <F2> <C-o>:setlocal spelllang=en_us spell! spell?<CR>

" Detect the current buffer's filetype
nnoremap <silent> <leader>f :filetype detect<CR>

" Refresh all loaded buffers
nnoremap <silent> <leader>gr :call refresh#RefreshBuffers()<CR>

" Shortcuts for .vimrc stuff
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <leader>ev :tabedit $MYVIMRC<CR>
""" END Keybindings

""" Commands
" Put all lines matching the pattern argument into a scratch buffer
command! -nargs=? Filter let @z='' | execute 'g/<args>/y Z' | vert new | setl bt=nofile | 0put! z
command! -nargs=? Vilter let @z='' | execute 'v/<args>/y Z' | vert new | setl bt=nofile | 0put! z

" Put the output of an arbitrary command into a scratch buffer
command! -complete=shellcmd -nargs=+ Shell call shellexec#ExecuteInShell(<q-args>)
command! -complete=file -nargs=* GitDiff call shellexec#ExecGitDiff(<q-args>)

" Wrapper around swap words for swapping quotes
command! -range SwapQuotes <line1>,<line2>call swap#SwapWords({"'":'"'})

"" Not actual commands, but abbreviations
" Open the help buffer in a full window
cabbrev ho <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tab h' : 'ho')<CR>

" Mimic a vertical version of :sb
cabbrev vsb <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert sb' : 'sb')<CR>
"" END abbreviations
""" END Custom Commands

""" Custom Functions
" Function to get the filesize in bytes and convert it to human-readable units
function! FileSize()
	let bytes = getfsize(expand("%:p")) " Get size of the file in bytes
	if bytes < 0
		return ""
	elseif bytes < 1024
		return bytes . "B"
	elseif bytes < 1048576
		return (bytes / 1024) . "kB"
	elseif bytes < 1073741824
		return (bytes / 1048576) . "MB"
	endif
	return "(╬ ಠ益ಠ)"
endfunction
""" END Custom Functions

" Use any of the user's local settings if they exist
if filereadable($MYVIMRC . '.local')
	source $MYVIMRC.local
endif
