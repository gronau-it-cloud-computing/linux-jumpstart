" Jump to subject and back via tags
nnoremap <buffer> <CR> <C-]>
nnoremap <buffer> <BS> <C-T>

" Use s and S to search by subject
nnoremap <buffer> o /'\l\{2,\}'<CR>
nnoremap <buffer> O ?'\l\{2,\}'<CR>

" Use o and O to search by option
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>

" Close help buffers with q, à la man
nnoremap <buffer> q :bw<CR>
