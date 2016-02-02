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

" Miscellaneous display niceties
setl nolist
setl nonumber
setl norelativenumber

" Some wizardry to make the page/terminal title all nice
let mantitle = toupper($MAN_PN)
execute 'silent file ' . mantitle
let &l:titlestring = mantitle

" Keybindings
nnoremap <buffer> q	:q<CR>
