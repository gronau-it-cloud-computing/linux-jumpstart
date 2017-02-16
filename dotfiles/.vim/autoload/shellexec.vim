"" Functions to execute shell commands and put them in a scratch buffer
" Bare function, takes any shell cmd
function! shellexec#ExecuteInShell(command)
	let command = join(map(split(a:command), 'expand(v:val)'))
	let winnr = bufwinnr('^' . command . '$')
	silent! execute  winnr < 0 ? 'vert botright new ' . fnameescape(command) : winnr . 'wincmd w'
	setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
	silent! execute 'silent %!' . command
	silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
	silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call shellexec#ExecuteInShell(''' . command . ''')<CR>'
endfunction

" Wrapper to ExecuteInShell for git diff
function! shellexec#ExecGitDiff(files)
	let files = join(map(split(a:files), 'expand(v:val)'))
	call shellexec#ExecuteInShell("git diff --cached " . files)
	setlocal ft=git
endfunction
