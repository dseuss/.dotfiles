nnoremap <leader>sd :FocusDispatch g++ % -g -o test; ./test<CR>

let b:fswitchlocs='reg:/src/src'

"" dont indent private/public keywords
set cindent
set cinoptions=g0
