" Fold manpages by section (or try to)
set foldenable
set foldmethod=indent
set foldnestmax=1

" It doesn't make sense to modify the buffer
set nomodified
set nomodifiable
set readonly

" You never know what's capitalised where
set ignorecase
set smartcase

" Miscellaneous display niceties
set nolist
set nonumber

" Keybindings
nmap q 			:q<CR>
nmap <SPACE>	<C-D>
nmap b			<C-U>
nmap <UP> 		<UP>
nmap <DOWN>		<DOWN>
nmap <LEFT>		<LEFT>
nmap <RIGHT>	<RIGHT>
nmap K			:Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>
