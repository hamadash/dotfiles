# zsh
setopt no_beep
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_dups
setopt hist_ignore_space # コマンドの先頭に半角スペースがある場合に履歴に残さない
setopt inc_append_history

# Docker
alias d='docker'
alias dcom='docker compose'

# git
alias g='git'

# nvim
alias vim="nvim"
alias view="nvim -R"

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# mysql
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

# peco
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# promptの表示設定
# -- start --
# ref. https://qiita.com/mikan3rd/items/d41a8ca26523f950ea9d

# git-promptの読み込み
source ~/dotfiles/.zsh/git-prompt.sh

# git-completionの読み込み
fpath=(~/dotfiles/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/dotfiles/.zsh/git-completion.bash
autoload -Uz compinit && compinit

# GitHub CLIの補完
eval "$(gh completion -s zsh)"

# プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# プロンプトの表示設定
setopt PROMPT_SUBST ; PS1='[%n %c$(__git_ps1 "(%s)")]\$'
# -- end --

# カスタムコマンド
export PATH=~/dotfiles/custom_commands:$PATH

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

fcd() {
    local dir
    dir=$(find . -type d -name '.*' -o -type d | fzf) && cd "$dir"
}

vf() {
  nvim "$(fzf)"
}

# zoxide
eval "$(zoxide init zsh)"

# tmux
export TMUX_TMPDIR=/tmp

# lazygit
alias lg="lazygit"

# autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# カレントディレクトリをタブに表示する
precmd() {
  print -Pn "\e]0;%~\a"
}

# libpg
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# asdf
# ref. https://asdf-vm.com/guide/getting-started.html
. /opt/homebrew/opt/asdf/libexec/asdf.sh
