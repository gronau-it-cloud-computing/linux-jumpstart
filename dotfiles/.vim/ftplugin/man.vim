" Fold manpages by section (or try to)
setl foldenable
setl foldmethod=indent
setl foldnestmax=1

" It doesn't make sense to modify the buffer
setl nomodified
setl nomodifiable
setl readonly

" You never know what's capitalised where
setl ignorecase
setl smartcase

" Obey MANWIDTH, if it is set
let &l:tw = $MANWIDTH ? $MANWIDTH : 0

" Miscellaneous display niceties
setl nolist
setl nonumber
setl norelativenumber

" Some wizardry to make the page/terminal title all nice
execute 'silent file ' . $MAN_PN

" Keybindings
nnoremap <buffer> q	:q<CR>
