" This has to be called before ftplugins are loaded. Therefore 
" it is here in ftdetect though it maybe shouldn't
" Edited by dsuess to work with completer choice
if has("autocmd") && (g:completer ==? 'ycm')
   autocmd FileType * call UltiSnips_FileTypeChanged()
endif

