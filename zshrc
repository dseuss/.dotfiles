source ~/.dotfiles/vars.sh

## OH-MY-ZSH SPECIFIC STUFF ###################################################
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.dotfiles/my-zsh
ZSH_THEME="customrobby"

DISABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
CASE_SENSETIVE="false"

# Load the oh-my-zsh plugins and settings
plugins=(command-not-found pass git z brew pip sublime zsh-syntax-highlighting tmux)
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

export ZSH_TMUX_AUTOCONNECT=false

# setup conda completion
zstyle ':completion::complete:*' use-cache 1
fpath+=$HOME/.dotfiles/conda-zsh-completion
compinit conda

# setup ssh completion in the right order
hosts=()
if [[ -r ~/.ssh/config ]]; then
  hosts=($hosts ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
  hosts=($hosts ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi
if [[ $#hosts -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $hosts
  zstyle ':completion:*:slogin:*' hosts $hosts
fi

## Personal aliases ###########################################################

source ~/.dotfiles/commands.sh
eval "$(hub alias -s)"

# Programming
alias vi="vim -u ~/.virc"
alias vim="nvim_tmuxed"
alias nvim="nvim_tmuxed"
alias svi="sudo vi -u ~/.virc"
alias cleanlatex="sh -c 'rm *.aux *.fdb_latexmk *.fls *.log *.synctex.gz *.out *.toc *.bib.bak *.end *.bbl *.blg *.toc *.auxlock *.table *.gnuplot'"
alias conf="vim ~/.zshrc"
# alias nb="tmux new -d -s ipython; tmux new-window -t ipython 'ipython notebook'"
alias pip-upgrade="pip install --upgrade"
alias pip-upgrade-all="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias pdb="python -m pdb"
alias acs="anaconda search -t conda"
alias ipy="ptipython"

# Git aliases
alias gs="git status -s"
alias gss="git --no-pager status"
alias ga="git add"
alias gl="git --no-pager lv -50 --no-merges"
alias gll="git lg"
alias gd="git difftool"
alias gf="git fetch"
alias gv="git difftool ...FETCH_HEAD"
alias gr="git rm"
alias gcd="cd \$(git rev-parse --show-cdup)"

# Science stuff
alias qtconsole="ipython qtconsole --pylab inline"
alias nb="tmux new -s ipython -d; tmux new-window -t ipython 'jupyter notebook'"
alias nb-kernels="tmux new -s ipython -d; tmux new-window -t ipython 'ipcluster start'"
alias evalnb="jupyter nbconvert --to html --ExecutePreprocessor.enabled=True"

# Admin/Sudo-Stuff
alias tardir='tar -zcvf'
alias untar='tar -zxvf'
alias mkdir='mkdir -pv'             # Create parent dirs on demand
alias ports='netstat -tulanp'
alias du="du -h"
alias df="df -h"
alias fzf="fzf-tmux"
alias f="fzf-tmux -m"
alias ssh="TERM=${TERM%-italic} ssh"
alias brew='TERM=xterm-256color brew'
alias ff='open -a Finder ./'

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on / #
# alias chown='chown --reserve-root'
# alias chmod='chmod --preserve-root'
# alias chgrp='chgrp --preserve-root'

# Printing
alias print-ls='lpstat -p -d'
alias clipboard='pbcopy'

#############################
#  Load the fzf extensions  #
#############################

source /usr/local/Cellar/fzf/0.11.4/shell/completion.zsh
source /usr/local/Cellar/fzf/0.11.4/shell/key-bindings.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

###-tns-completion-start-###
if [ -f /Users/dsuess/.tnsrc ]; then
    source /Users/dsuess/.tnsrc
fi
###-tns-completion-end-###
