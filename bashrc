source ~/.dotfiles/aliases

if [ -e ~/.bashrc.local ]; then
   source ~/.bashrc.local
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
