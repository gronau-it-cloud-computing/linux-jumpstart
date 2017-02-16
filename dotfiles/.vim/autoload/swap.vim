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
function! swap#SwapWords(dict, ...) range
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
