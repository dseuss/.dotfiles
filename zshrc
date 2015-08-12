export PYTHONPATH=~/Code/Pythonlibs:$PYTHONPATH
export GOPATH=~/Code/Go/
export PATH=~/bin/:$GOPATH/bin:$PATH
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


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


## Personal aliases ###########################################################

source ~/.dotfiles/commands.sh

# Programming
alias vi="vim -u ~/.virc"
alias vim="vim_tmuxed"
alias gvim="gvim --remote-silent"
alias svi="sudo vi -u ~/.virc"
alias latexmk="latexmk -pdf"
alias cleanlatex="sh -c 'rm *.aux *.fdb_latexmk *.fls *.log *.synctex.gz *.out *.toc *.bib.bak *.end *.bbl *.blg *.toc *.auxlock'"
alias conf="vim ~/.zshrc"
# alias nb="tmux new -d -s ipython; tmux new-window -t ipython 'ipython notebook'"
alias pip-upgrade="pip install --upgrade"
alias pip-upgrade-all="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias pdb="python -m pdb"

# Git aliases
alias gs="git --no-pager status"
alias ga="git add"
alias gl="git --no-pager lv -50 --no-merges"
alias gll="git lg"
alias gd="git difftool"
alias gf="git fetch"
alias gv="git difftool ...FETCH_HEAD"
alias gr="git rm"

# Science stuff
alias qtconsole="ipython qtconsole --pylab inline"
alias nb="tmux new -s ipython -d; tmux new-window -t ipython 'ipython notebook'"
alias evalnb="ipython nbconvert --to html --ExecutePreprocessor.enabled=True"

# Admin/Sudo-Stuff
alias tardir='tar -zcvf'
alias untar='tar -zxvf'
alias mkdir='mkdir -pv'             # Create parent dirs on demand
alias ports='netstat -tulanp'
alias du="du -h"
alias df="df -h"
alias f="find . | grep"
alias ssh="TERM=${TERM%-italic} ssh"

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
