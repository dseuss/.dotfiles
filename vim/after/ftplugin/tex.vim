" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
setlocal grepprg=grep\ -nH\ $*
"au BufWritePost *.tex,*.bib, silent! !ctags-exuberant -R -f .vimtags &

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
setlocal sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
setlocal iskeyword+=:


" Disable column marker
setlocal textwidth=0
setlocal colorcolumn=0
setlocal wrap

" Mappings for ATP
nnoremap <buffer> <leader>ll :MakeLatex<CR>
nnoremap <buffer> <leader>ls :SyncTex<CR>
nnoremap <buffer> <leader>lv :View<CR>

" Disable folding -> should speed up
" setlocal foldmethod=manual
" setlocal foldnestmax=0
" Try this for further speed up
" syntax sync maxlines=100
" syntax sync minlines=20

" Always enable spell checking (english on default)
setlocal spell

" Local Tag file
set tags+=tags

" Enable the Buffer Tags for tex files
let g:ctrlp_buftag_types =  {
         \ 'tex' : '',
         \}

" Run latexmk for bib, pictures, etc.
noremap <leader>lm :!latexmk -pdflatex='pdflatex --synctex=1 --file-line-error-style --interaction=nonstopmode' -pdf<CR>

" Simply add left/right to brackets
nnoremap <leader>l% i\left<esc>l%i\right<esc>l

" Fill line with comments
let b:fillchar = '%'

" Add some custom surround environments
" see help surround-customizing
let b:surround_36 = "$\r$"
let g:surround_99 = "\\\1command: \1{\r}"

"" Enable text mode for neocomplete
let g:neocomplete#text_mode_filetypes = {'tex': 1}
