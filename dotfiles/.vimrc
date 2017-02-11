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
set wildignore+=.*.sw?,*.pyc,*.class,*.o				" Ignore these things in tab completion
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
"" CursorLine
highlight CursorLine cterm=NONE ctermbg=DarkGrey ctermfg=NONE

"" ColorColumn
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

" Bind :w!! to WRITE WITH EXTREME PREJUDICE
cnoremap w!! w !sudo tee % >/dev/null

" Bind C-<Direction> to move windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Bind <leader>-<Direction> to move tabs
noremap <leader>h gT
noremap <leader>l gt
" And <leader>-<Shift>-<Direction> to first/last tab
noremap <silent> <leader>H :tabfirst<CR>
noremap <silent> <leader>L :tablast<CR>

" Next/Previous buffer
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

" Make Y act like you'd expect it to
nnoremap Y y$

" Shortcuts for .vimrc stuff
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <silent> <leader>ev :tabedit $MYVIMRC<CR>

" Set up default readline keys for commandline
cnoremap <C-a>	<Home>
cnoremap <C-e>	<End>
cnoremap <Esc>b	<S-Left>
cnoremap <Esc>f	<S-Right>

" Delete for real
nnoremap <leader>d "_d
nnoremap <leader>D "_D

" Some shortcuts for system clipboards
nnoremap <leader>p "+p
nnoremap <leader>P "*p
nnoremap <leader>y "+y
nnoremap <leader>Y "*y

" Detect the current buffer's filetype
nnoremap <silent> <leader>f :filetype detect<CR>
""" END Keybindings

""" Commands
" Put all lines matching the pattern argument into a scratch buffer
command! -nargs=? Filter let @z='' | execute 'g/<args>/y Z' | vert new | setl bt=nofile | 0put! z
command! -nargs=? Vilter let @z='' | execute 'v/<args>/y Z' | vert new | setl bt=nofile | 0put! z

" Put the output of an arbitrary command into a scratch buffer
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
command! -complete=file -nargs=* GitDiff call s:ExecGitDiff(<q-args>)

" Wrapper around swap words for swapping quotes
command! -range SwapQuotes <line1>,<line2>call s:SwapWords({"'":'"'})

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

"" Functions to execute shell commands and put them in a scratch buffer
" Bare function, takes any shell cmd
function! s:ExecuteInShell(command)
	let command = join(map(split(a:command), 'expand(v:val)'))
	let winnr = bufwinnr('^' . command . '$')
	silent! execute  winnr < 0 ? 'vert botright new ' . fnameescape(command) : winnr . 'wincmd w'
	setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
	silent! execute 'silent %!' . command
	silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
	silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
endfunction

" Wrapper to ExecuteInShell for git diff
function! s:ExecGitDiff(files)
	let files = join(map(split(a:files), 'expand(v:val)'))
	call s:ExecuteInShell("git diff --cached " . files)
	setlocal ft=git
endfunction

"" Functions for swapping arbitrary strings
" Reverse a dictionary
function! s:Mirror(dict)
	for [key, value] in items(a:dict)
		let a:dict[value] = key
	endfor
	return a:dict
endfunction

function! s:S(number)
	return submatch(a:number)
endfunction

" Swap two arbitrary strings
function! s:SwapWords(dict, ...) range
	let words = keys(a:dict) + values(a:dict)
	let words = map(words, 'escape(v:val, "|")')
	if(a:0 == 1)
		let delimiter = a:1
	else
		let delimiter = '/'
	endif
	let pattern = '\v(' . join(words, '|') . ')'
	exe a:firstline . ',' . a:lastline . 's' . delimiter . pattern . delimiter
		\ . '\=' . string(<SID>Mirror(a:dict)) . '[<SID>S(0)]'
		\ . delimiter . 'g'
endfunction
""" END Custom Functions

" Use any of the user's local settings if they exist
if filereadable($MYVIMRC . '.local')
	source $MYVIMRC.local
endif
