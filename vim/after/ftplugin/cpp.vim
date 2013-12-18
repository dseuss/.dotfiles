nnoremap <leader>sd :FocusDispatch g++ % -g -o test; ./test<CR>

let b:fswitchlocs='reg:/src/src'

" CINDENT
set cindent
"" dont indent private/public keywords
set cinoptions+=g0
"" Indent additional function parameters to "("
set cino+=(0

" ALIGN
vnoremap <leader>a// :Align\/\/<CR>

" Add highlighting for function definition in C++
function! EnhanceCppSyntax()
  syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
  hi def link cppFuncDef Special
endfunction
autocmd Syntax cpp call EnhanceCppSyntax()

set number
set relativenumber

" Shortcuts for YCM-commands
nnoremap <buffer> <leader>rd :YcmCompleter GoToDefinitionElseDeclaration<CR>
