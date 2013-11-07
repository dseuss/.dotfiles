" recognize .snippet files
" edited by dsuess to work with completer-choice
if has("autocmd") && (g:completer ==? 'ycm')
    autocmd BufNewFile,BufRead *.snippets setf snippets
endif
