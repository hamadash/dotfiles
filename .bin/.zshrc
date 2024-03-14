# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# mysql
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# peco
function peco-history-selection() {  
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`  
    CURSOR=$#BUFFER  
    zle reset-prompt  
}  
zle -N peco-history-selection  
bindkey '^R' peco-history-selection  

# promptの表示設定
# ref. https://qiita.com/mikan3rd/items/d41a8ca26523f950ea9d

# git-promptの読み込み
source ~/dotfiles/.zsh/git-prompt.sh

# git-completionの読み込み
fpath=(~/dotfiles/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/dotfiles/.zsh/git-completion.bash
autoload -Uz compinit && compinit

# プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# プロンプトの表示設定
setopt PROMPT_SUBST ; PS1='[%n %c$(__git_ps1 "(%s)")]\$'

# コマンド履歴を重複して登録しない
setopt hist_ignore_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space

# カスタムコマンド
export PATH=~/dotfiles/custom_commands:$PATH

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
