export EDITOR=/usr/local/bin/nvim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=$HOME/bin/:$HOME/.local/bin/:$PATH

export PYTHONPATH=$HOME/Code/Pythonlibs:$PYTHONPATH

export CC=clang
export CXX=clang++
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
export CFLAGS="-isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.1.sdk// $CFLAGS"

#export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src

export FZF_DEFAULT_COMMAND='fd --type f'

export DUCK="/Users/dsuess/Library/Group Containers/G69SCX94XU.duck/Library/Application Support/duck/Volumes/"
