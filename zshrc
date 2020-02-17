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
plugins=(git pip tmux)
source $ZSH/oh-my-zsh.sh
# setup conda completion
fpath+=~/.dotfiles/my-zsh/plugins/dvc/
fpath+=~/.dotfiles/conda-zsh-completion
compinit -i
zstyle ':completion::complete:*' use-cache 1


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
if [ -e ~/.zshrc.local ]; then
   source ~/.zshrc.local
fi

if [[ ! -z "$DIRENV_DIR" ]]; then
   direnv reload
fi

source ~/.dotfiles/aliases

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
