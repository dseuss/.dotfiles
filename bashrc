if [ -e ~/.dotfiles/vars.sh ]; then
   source ~/.dotfiles/vars.sh
fi
if [ -e ~/.bashrc.local ]; then
   source ~/.bashrc.local
fi

source ~/.dotfiles/aliases

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
