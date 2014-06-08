" Completion function
setlocal omnifunc=necoghc#omnifunc

" Use all conceal features in all modes
set concealcursor=nvic

" Load current file in ghci
nnoremap <leader>i :Dispatch\ ghci\ %<CR>

setlocal makeprg=source\ ~/.dotfiles/zsh/cabal.zsh;ghci\ %
