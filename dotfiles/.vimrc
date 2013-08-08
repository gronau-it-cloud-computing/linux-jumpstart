" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Automagical filetype autoindentation.
if has("autocmd")
	filetype plugin indent on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set bg=dark

" Turn on line numbers
set nu

" Set tab == 4
set ts=4
set sw=4

" Turn on auto-indent
set ai

" Prefer unix files
set ffs=unix,dos

" Always show status line
set laststatus=1

" Set PAGER for man viewing
let $PAGER=''

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set ruler			" Show position in document at all times (l,c,%)
set nohlsearch		" Do not highlight every occurance matching the last search pattern

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Bind F3 to timestamp HH:MM:SS AP:\t
nmap <F3> a<C-R>=strftime("%I:%M:%S %p:\t")<CR>
imap <F3> <C-R>=strftime("%I:%M:%S %p:\t")<CR>

" Bind F2 to toggle spellcheck
nnoremap <F2> :setlocal spelllang=en_us spell! spell?<CR>
inoremap <F2> <C-o>:setlocal spelllang=en_us spell! spell?<CR>
