" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" Uncomment this on Debian and Debian-based distros
"runtime! debian.vim

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

let $PAGER=''					" Set PAGER for man viewing
set bg=dark						" Look nice (readable) on a dark background
set	number						" Show line numbers
set autoindent					" Turn on auto-indent
set ffs=unix,dos				" Prefer Unix-style files
set tabstop=4					" Make tab four spaces
set shiftwidth=4				" Make shift width four spaces
set showcmd						" Show (partial) command in status line.
set showmatch					" Show matching brackets.
set autowrite					" Automatically save before commands like :next and :make
set nohlsearch					" Do not highlight every occurrence matching the last search pattern
set diffopt=filler,vertical		" User filler lines to keep files aligned, default to vertical split
set cursorline					" Highlight current line

" Status Line
set laststatus=2				" Always show status line
set statusline=%f\ 				" Filename (without path)
set statusline+=[%{&ff}]\ 		" File format
set statusline+=%-6{FileSize()}	" File size
set statusline+=%4(%m%)			" Modified flag
set statusline+=%-10(%r%)		" Readonly flag
set statusline+=%(CHAR\ %-4b%)	" Character value
set statusline+=%=				" Left/Right division point
set statusline+=LN\ %l/%L\ 		" Line number
set statusline+=COL\ %-8(%c%V%)	" Column number
set statusline+=%P				" Percentage through file

" Bind F2 to toggle spellcheck in normal and insert modes
nnoremap <F2> :setlocal spelllang=en_us spell! spell?<CR>
inoremap <F2> <C-o>:setlocal spelllang=en_us spell! spell?<CR>

" Use any of the user's local settings if they exist
if filereadable("~/.vimrc.local")
	source ~/.vimrc.local
endif

function! FileSize()
	let bytes = getfsize(expand("%:p"))
	if bytes <= 0
		return ""
	endif
	if bytes < 1024
		return bytes
	endif
	if bytes < 1048576
		return (bytes / 1024) . "K"
	endif
	if bytes < 1073741824
		return (bytes / 1048576) . "M"
	endif
	if bytes < 1099511627776
		return (bytes / 1073741824) . "G"
	else
		return ";_;"
	endif
endfunction
