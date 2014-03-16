" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Automagical syntax highlighting
if has("syntax")
  syntax on
endif

" Automagical filetype autoindentation.
if has("autocmd")
	filetype plugin indent on
endif

" Automagically open, but do not go to, the quickfix window
" or close it when it becomes empty
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Miscellaneous options
let $PAGER=''											" Set PAGER for man viewing
set background=dark										" Look nice on a dark background
set	number												" Show line numbers
set autoindent											" Turn on auto-indent
set fileformats=unix,dos								" Automagically detect format by EOL
set tabstop=4											" Make tab four spaces
set shiftwidth=4										" Make shift width four spaces
set showcmd												" Show command in status line.
set showmatch											" Show matching brackets.
set autowrite											" Automagically save before some commands
set nohlsearch											" Do not highlight every match
set diffopt=filler,vertical								" Keep files aligned, default to vsplit
set cursorline											" Highlight current line
set nrformats=alpha,octal,hex							" {in,de}crementing of alpha, octal, hex
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<	" Keep tab-aligned when list is enabled
set hidden												" Keeps abandoned buffers loaded. Beware!

" Status Line
set laststatus=2										" Always show status line
set statusline=%4.4([%02.2n]%)\ 	 					" Show the buffer number
set stl+=%-40.40f\ 										" Filename (with relative path, or as typed)
set stl+=%-7.7([%{&ff}]%)								" File format
set stl+=%-15.15([%{''.(&fenc!=''?&fenc:&enc).''}]%)	" Encoding
set stl+=%6.6{FileSize()}								" File size
set stl+=%4.4(%4.4m%)									" Modified flag
set stl+=%4.4(%4.4r%)									" Readonly flag
set stl+=%-7.7(%{(&bomb?\"[BOM]\":\"\")}%)				" Byte-order mark flag
set stl+=%=												" Left/Right division point
set stl+=LN\ %l/%L\ 									" Line number
set stl+=COL\ %-8(%c%V%)								" Column number
set stl+=%P												" Percentage through file

" Keybindings
" Disable arrow keys in normal, visual, and insert modes
noremap 	<LEFT>	<NOP>
noremap 	<DOWN>	<NOP>
noremap 	<RIGHT>	<NOP>
noremap		<UP>	<NOP>
inoremap 	<LEFT>	<NOP>
inoremap 	<DOWN>	<NOP>
inoremap 	<RIGHT>	<NOP>
inoremap 	<UP>	<NOP>

" Bind F2 to toggle spellcheck in normal and insert modes
nnoremap <F2> :setlocal spelllang=en_us spell! spell?<CR>
inoremap <F2> <C-o>:setlocal spelllang=en_us spell! spell?<CR>

" Custom functions
" Function to get the filesize in bytes and convert it to human-readable units
function! FileSize()
	" Get size of the file in bytes
	let bytes = getfsize(expand("%:p"))
	if bytes < 0
		return ""
	endif
	" If there is less than 1KB, display in B
	if bytes < 1024
		return bytes . "B"
	endif
	" If there are more that 1023 B, but less than 1MB, display in KB
	if bytes < 1048576
		return (bytes / 1024) . "KB"
	endif
	" If there are more than 1023KB, but less than 1GB, display in MB
	if bytes < 1073741824
		return (bytes / 1048576) . "MB"
	" This file is a gig or larger, cry
	else
		return "(•̩̩̩̩＿•̩̩̩̩)"
	endif
endfunction

" Use any of the user's local settings if they exist
if filereadable("~/.vimrc.local")
	source ~/.vimrc.local
endif
