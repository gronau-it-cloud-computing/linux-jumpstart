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
set laststatus=1				" Always show status line
set ffs=unix,dos				" Prefer Unix-style files
set tabstop=4					" Make tab four spaces
set shiftwidth=4				" Make shift width four spaces
set showcmd						" Show (partial) command in status line.
set showmatch					" Show matching brackets.
set autowrite					" Automatically save before commands like :next and :make
set ruler						" Show position in document at all times (l,c,%)
set nohlsearch					" Do not highlight every occurance matching the last search pattern
set diffopt=filler,vertical		" User filler lines to keep files aligned, default to vertical split

" Bind F2 to toggle spellcheck in normal and insert modes
nnoremap <F2> :setlocal spelllang=en_us spell! spell?<CR>
inoremap <F2> <C-o>:setlocal spelllang=en_us spell! spell?<CR>

" Use any of the user's local settings if they exist
if filereadable("~/.vimrc.local")
	source ~/.vimrc.local
endif
