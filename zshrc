# sandbox aware wrappers for ghc/ghci
source ~/.dotfiles/vars.sh

## OH-MY-ZSH SPECIFIC STUFF ###################################################
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.dotfiles/my-zsh
ZSH_THEME="customrobby"

DISABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
CASE_SENSETIVE="true"

# Load the oh-my-zsh plugins and settings
plugins=(command-not-found git pip zsh-syntax-highlighting tmux)
source $ZSH/oh-my-zsh.sh

## Final customization of zsh #################################################

# Write history of multiple zsh-sessions chronologicaly ordered
setopt inc_append_history

# Share history over multiple sessions
setopt share_history

# Disable the anoying autocorrect
unsetopt correct

# Hit escape twice to clear the current input line
bindkey "" vi-change-whole-line

# Disable <c-s> for stopping terminal
stty stop undef
stty start undef


# Personal aliases ###########################################################
source ~/.dotfiles/aliases

if [ -e ~/.zshrc.local ]; then
   source ~/.zshrc.local
fi

if [[ ! -z "$DIRENV_DIR" ]]; then
   direnv reload
fi
