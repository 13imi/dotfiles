#=================##
## File Operation ##
##=================#
autoload -U compinit && compinit
setopt auto_cd
setopt auto_pushd
setopt correct
setopt magic_equal_subst
setopt nobeep
setopt prompt_subst
setopt list_packed

zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# vcs_info
autoload vcs_info
# gitのみ有効にする
zstyle ":vcs_info:*" enable git
# commitしていない変更をチェックする
zstyle ":vcs_info:git:*" check-for-changes true
# gitリポジトリに対して、変更情報とリポジトリ情報を表示する
zstyle ":vcs_info:git:*" formats "%c%u[%b:%r]"
# gitリポジトリに対して、コンフリクトなどの情報を表示する
zstyle ":vcs_info:git:*" actionformats "%c%u<%a>[%b:%r]"
# addしていない変更があることを示す文字列
zstyle ":vcs_info:git:*" unstagedstr "<U>"
# commitしていないstageがあることを示す文字列
zstyle ":vcs_info:git:*" stagedstr "<S>"

# Enterでlsとgit status
# function do_enter() {
#     if [ -n "$BUFFER" ]; then
#         zle accept-line
#         return 0
#     fi
#     echo
#     ls
#     # ↓おすすめ
#     # ls_abbrev
#     if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
#         echo
#         echo -e "\e[0;33m--- git status ---\e[0m"
#         git status -sb
#     fi
#     zle reset-prompt
#     return 0
# }
# zle -N do_enter
# bindkey '^m' do_enter

# setting for peco
for f ($HOME/dotfiles/.zsh/peco-sources/*) source "${f}" # load peco sources
bindkey '^r' peco-select-history
bindkey '^[' peco-cdr

# git：まだpushしていないcommitあるかチェックする
my_git_info_push () {
	if [ "$(git remote 2>/dev/null)" != "" ]; then
		local head="$(git rev-parse HEAD)"
		local remote
		for remote in $(git rev-parse --remotes) ; do
			if [ "$head" = "$remote" ]; then return 0 ; fi
		done
		# pushしていないcommitがあることを示す文字列
		echo "<P>"
	fi
}

# git：stashに退避したものがあるかチェックする
my_git_info_stash () {
	if [ "$(git stash list 2>/dev/null)" != "" ]; then
		# stashがあることを示す文字列
		echo "{s}"
	fi
}

# vcs_infoの出力に独自の出力を付加する
my_vcs_info () {
	vcs_info
	echo $(my_git_info_stash)$(my_git_info_push)$vcs_info_msg_0_
}

#=========##
## PROMPT ##
##=========#
autoload colors
colors
PROMPT="%{${fg[blue]}%}[%n] %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[blue]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[red]}%}[%~]%{${reset_color}%}"

# プロンプト定義
RPROMPT=$'%F{077}$(my_vcs_info)%}%f%F{038}[%~]%f'
#RPROMPT="%F{038}[%f%F{077}%{$(my_vcs_info)%}%f%F{038}%~]%f"

#================##
## ALIAS COMMAND ##
##================#
setopt complete_aliases
alias g='git'
alias ls="ls -G -w -h"
alias la="ls -a"
alias lf="ls -F"
alias l="la -lh"
alias du="du -h"
alias df="df -h"
alias -s txt=lv
alias -s md=lv
alias -s markdown=lv
alias -s xml=lv
alias vi="vim"
alias bup="brew update"
alias brug="brew upgrade"
alias bs="brew -S"
alias bi="brew info"
alias be='bundle exec'
alias b='bundle'
alias binit='bundle init; bundle install --path vendor/bundle'
alias col='ssh okumura@collagree.com'
alias zc='z collagree'
alias bs='bundle exec spring rails s'
alias bc='bundle exec rails c'

#===========##
## HISTORY  ##
##===========#
## ヒストリを保存するファイル
HISTFILE=~/.zsh_history
## メモリ上のヒストリ数。
## 大きな数を指定してすべてのヒストリを保存するようにしている。
HISTSIZE=10000000
## 保存するヒストリ数
SAVEHIST=$HISTSIZE
## ヒストリファイルにコマンドラインだけではなく実行時刻と実行時間も保存する。
setopt extended_history
## 同じコマンドラインを連続で実行した場合はヒストリに登録しない。
setopt hist_ignore_dups
## スペースで始まるコマンドラインはヒストリに追加しない。
setopt hist_ignore_space
## すぐにヒストリファイルに追記する。
setopt inc_append_history
## zshプロセス間でヒストリを共有する。
setopt share_history
## C-sでのヒストリ検索が潰されてしまうため、出力停止・開始用にC-s/C-qを使わない。
setopt no_flow_control

#================================##
## Version Control for Languages ##
##================================#
# rbenv
if which rbenv > /dev/null; then
    eval "$(rbenv init - zsh)"
    source "`brew --prefix rbenv`/completions/rbenv.zsh"
fi

#==================##
## zsh-completions ##
##==================#
fpath=(/usr/local/share/zsh-completions $fpath)

#================================##
## source zsh-syntax-highlighting #
##================================#
[[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && . ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#====##
## z ##
##====#
. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
z --add "$(pwd -P)"
}
