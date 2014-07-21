# Proper color support for vim
if [ "$TERM" = "xterm" ]; then
   export TERM=xterm-256color-italic
fi

export PATH=/home/dsuess/bin:/home/dsuess/.local/src/gcc-4.9-32bit/bin/:$PATH
export PATH=~/.cabal/bin:$PATH

export PYTHONPATH=~/Documents/python:$PYTHONPATH

emulate bash
if [ -f /opt/intel/bin/compilervars.sh ]; then
   source /opt/intel/bin/compilervars.sh intel64
fi
emulate zsh

# sandbox aware wrappers for ghc/ghci
source ~/.dotfiles/zsh/cabal.zsh


## OH-MY-ZSH SPECIFIC STUFF ###################################################
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Case sensetive completion
CASE_SENSETIVE="true"

# Load the oh-my-zsh plugins and settings
plugins=(command-not-found pass git cabal pylint z)
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

# Programming
alias vi="/usr/local/bin/vim -u ~/.virc"
alias gvim="gvim --remote-silent"
alias svi="sudo vi -u ~/.virc"
alias latexmk="latexmk -pdf"
alias cleanlatex="sh -c 'rm --force *.aux *.fdb_latexmk *.fls *.log *.synctex.gz *.out *.toc *.bib.bak *.end *.bbl *.blg *.toc *.auxlock'"
alias py="python2.7"
alias conf="vim ~/.zshrc"
alias nb="ipython notebook"
alias ijulia="ipython notebook --profile julia"
# alias pipupdate="pip#  freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs sudo pip install -U"
# alias IHaskell="IHaskell --ipython=$(which ipython)"

# Git aliases
alias gs="git --no-pager status"
alias ga="git add"
alias gl="git --no-pager lv -50"
alias gll="git lg"
alias gd="git vimdiff"

# Network stuff
#alias ssh="ssh -Y"
alias chromium-proxified="chromium-browser --proxy-server=\"socket5://localhost:8080\""
alias mount-remote-home="sshfs -C dsuess@vesta:/home/dsuess /media/rhome/"
alias ssh-keychain="eval \$(keychain --eval --agents ssh -Q --quiet id_rsa)"

# Science stuff
alias qtconsole="ipython qtconsole --pylab inline"
alias notebook="ipython notebook --browser=\"/usr/bin/firefox\" --pylab inline "

# Admin/Sudo-Stuff
alias l.='ls -d .* --color=auto'    # Display hidden files
alias tardir='tar -zcvf'
alias untar='tar -zxvf'
alias mkdir='mkdir -pv'             # Create parent dirs on demand
alias ports='netstat -tulanp'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -h now'

# Apt-get shortcuts
alias agi="sudo apt-get install"
alias agd="sudo apt-get update"
alias agg="sudo apt-get upgrade"

# Div. Application shortcuts
alias hamster='hamster-cli'

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Printing
alias print-ls='lpstat -p -d'
