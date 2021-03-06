# 言語設定
export LANG=ja_JP.UTF-8

# カラー設定
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# Homebrew用PATH指定
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share:/usr/local/share/python:$PATH

# rbenv,phpenv用設定
export PATH=$HOME/.phpenv/bin:$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH

export PATH=$PATH:/usr/local/share/npm/bin
export NODE_PATH=/usr/local/lib/node_modules

# golang用設定
export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
