export EDITOR=/usr/local/bin/nvim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=$HOME/bin/:$HOME/Library/Miniconda3/bin:$HOME/.local/bin/:$HOME/.cargo/bin/:/usr/local/opt/llvm/bin:$PATH

export PYTHONPATH=~/Code/Pythonlibs:$PYTHONPATH
export TF_CPP_MIN_LOG_LEVEL=3

export CC=clang
export CXX=clang++

export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src

export FZF_DEFAULT_COMMAND='fd --type f'
