" Completion function
setlocal omnifunc=necoghc#omnifunc

" Use all conceal features in all modes
set concealcursor=nvic

" Dispatch = load current file in ghci
let b:dispatch = 'source ~/.dotfiles/zsh/cabal.zsh;ghci %'
