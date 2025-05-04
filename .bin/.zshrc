##########
# 基本設定
##########
# ビープ音を無効化
setopt no_beep
# ディレクトリ名だけで cd する
setopt auto_cd
# pushd/popd の設定
setopt auto_pushd
setopt pushd_ignore_dups
# コマンド履歴
setopt hist_ignore_dups
setopt hist_ignore_space # 先頭に半角スペースがあるコマンドは履歴に残さない
setopt inc_append_history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

##########
# パスの設定
##########
# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# MySQL
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

# PostgreSQL
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# custom_commands
export PATH=~/dotfiles/custom_commands:$PATH

# asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# tmux
export TMUX_TMPDIR=/tmp

##########
# エイリアス
##########
# Docker
alias d='docker'
alias dcom='docker compose'

# Git
alias g='git'

# Neovim
alias vim="nvim"
alias view="nvim -R"

# lazygit
alias lg="lazygit"

##########
# プロンプト設定
##########
setopt PROMPT_SUBST ; PS1='[%n %c$(__git_ps1 "(%s)")]\$'

# git-prompt の読み込み
source ~/dotfiles/.zsh/git-prompt.sh

# git-completion の読み込み
fpath=(~/dotfiles/.zsh $fpath)
autoload -Uz compinit && compinit
zstyle ':completion:*:*:git:*' script ~/dotfiles/.zsh/git-completion.bash

# GitHub CLI 補完
eval "$(gh completion -s zsh)"

# プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# カレントディレクトリをタブに表示する
precmd() {
  print -Pn "\e]0;%~\a"
}

##########
# 補完・サジェスト・ハイライト
##########
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zoxide
eval "$(zoxide init zsh)"

##########
# peco
##########
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

##########
# カスタム関数
##########
# fzf でディレクトリを選んで cd
fcd() {
    local dir
    dir=$(find . -type d -name '.*' -o -type d | fzf) && cd "$dir"
}

# fzf でファイルを選んで nvim で開く
vf() {
    nvim "$(fzf)"
}
