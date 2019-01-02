it2prof() { echo -e "\033]50;SetProfile=$1\a" }

nvim_tmuxed() {
   VIM=/usr/local/bin/nvim
   if [ -z "$TMUX" ]; then
      if [ -z "$1" ]; then
         tmux new "reattach-to-user-namespace -l ${VIM}"
      else
         tmux new "reattach-to-user-namespace -l ${VIM} $(printf '%q' "$@")"
      fi
   else
      if [ -z "$1" ]; then
         "${VIM}"
      else
         "${VIM}" $(printf '%q' "$@")
      fi
   fi
}


multissh() {
   # Based on http://linuxpixies.blogspot.jp/2011/06/tmux-copy-mode-and-how-to-control.html
   # a script to ssh multiple servers over multiple tmux panes

   # Setup the ssh-keychain
   eval $(keychain --eval --agents ssh -Q --quiet id_rsa)

   # Check if we are inside tmux
   if [ ! -n "$TMUX" ]; then
      tmux new-session "exec $BASH_SOURCE $*"
      exit
   fi

   hosts=( $@ )
   # if [ ${hosts[0]} == 'all' ]; then
   #    hosts=( 02 04 05 06 07 09 10 11 13 14 15 16 )
   # fi

   tmux new-window "ssh -t ${hosts[0]}"
   unset hosts[0];
   for i in "${hosts[@]}"; do
      tmux split-window -h  "ssh -t $i"
      tmux select-layout tiled > /dev/null
   done
   tmux select-pane -t 1
   tmux set-window-option synchronize-panes on > /dev/null

   sleep 5
   tmux select-layout tiled > /dev/null
}

add_to_path() {
    export PATH=$PATH:$1
}

remove_from_path() {
    export PATH=`echo ${PATH} | awk -v RS=: -v ORS=: $1' {next} {print}'`
}

ssh-ec2() {
    TERM=xterm-256color ssh -i $HOME/.ssh/id_ec2.pem "ec2-user@$1" ${@:2}
}

change-mac() {
    sudo ifconfig en0 ether $(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
}

ssh-sync() {
    if [ -z ${1+x} ]; then
        echo "Please specify target server"
        return -1
    fi
    if [ -z ${SSH_SYNC_SRC_DIR+x} ]; then
        echo "SSH_SYNC_SRC_DIR not set"
        return -1
    fi
    if [ -z ${SSH_SYNC_DEST_DIR+x} ]; then
        echo "SSH_SYNC_DEST_DIR not set"
        return -1
    fi

    tmux new -d -s tasks
    echo ---- $SSH_SYNC_ARGS
    tmux new-window -t tasks "/Users/dsuess/bin/fswatch-rsync \"$SSH_SYNC_SRC_DIR\" \"$SSH_SYNC_DEST_DIR\" \"$1\" \"$SSH_SYNC_ARGS\""
    tmux rename-window -t tasks "ssh-sync $1"
}

nb () {
    tmux new -d -s tasks
    tmux new-window -t tasks 'reattach-to-user-namespace -l /Users/dsuess/Library/Conda/bin/jupyter notebook'
}

jl () {
    tmux new -d -s tasks
    tmux new-window -t tasks 'reattach-to-user-namespace -l /Users/dsuess/Library/Conda/bin/jupyter lab'
}

taskr () {
    tmux new -d -s tasks
    tmux new-window -t tasks "$@"
}
