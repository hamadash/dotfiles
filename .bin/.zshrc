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

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

# eval "$(cmd ...)" の出力をファイルにキャッシュして source する
cached_eval() {
  local cache="$HOME/.zsh/cache/${1//\//_}.zsh"

  if [[ ! -s "$cache" ]]; then
    mkdir -p "${cache:h}"
    "$@" > "$cache"
  fi

  source "$cache"
}

##########
# パスの設定
##########

# MySQL
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

# PostgreSQL
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# custom_commands
export PATH="$HOME/dotfiles/custom_commands:$PATH"

# .local/bin
export PATH="$HOME/.local/bin:$PATH"

# tmux
export TMUX_TMPDIR=/tmp

##########
# 開発ツール
##########

eval "$(mise activate zsh)"

##########
# エイリアス
##########

# bat
alias cat='bat'

# eza
alias ls='eza --icons auto -F always --hyperlink -h'

##########
# プロンプト設定
##########

# git-prompt の読み込み (starship を使わない場合に利用)
source "$HOME/dotfiles/.zsh/git-prompt.sh"

# git-completion の読み込み
fpath=("$HOME/dotfiles/.zsh" $fpath)

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi

zstyle ':completion:*:*:git:*' script "$HOME/dotfiles/.zsh/git-completion.bash"

# GitHub CLI 補完
GH_COMP_CACHE="$HOME/.zsh/cache/gh_completion"

if [[ ! -f "$GH_COMP_CACHE" ]]; then
  mkdir -p "${GH_COMP_CACHE:h}"
  gh completion -s zsh > "$GH_COMP_CACHE" 2>/dev/null
fi

[[ -f "$GH_COMP_CACHE" ]] && source "$GH_COMP_CACHE"

# starship
cached_eval starship init zsh

# starship を使わない場合の設定
# setopt PROMPT_SUBST
# PROMPT='$(__git_ps1 "(%s) ")'$PROMPT

# プロンプトのオプション表示設定
# GIT_PS1_SHOWDIRTYSTATE=false
# GIT_PS1_SHOWUNTRACKEDFILES=false
# GIT_PS1_SHOWSTASHSTATE=false
# GIT_PS1_SHOWUPSTREAM=none

# カレントディレクトリをタブに表示する
set_terminal_title() {
  print -Pn "\e]0;%~\a"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set_terminal_title

##########
# 補完・サジェスト・ハイライト
##########

# fzf
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# zoxide
cached_eval zoxide init zsh

##########
# peco
##########

peco-history-selection() {
  BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | peco)
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

  dir=$(find . -type d | fzf) && cd "$dir"
}

# fzf でファイルを選んで nvim で開く
vf() {
  nvim "$(fzf)"
}

# git 管理しているプロジェクトルートに戻る
gcd() {
  local root

  root=$(git rev-parse --show-toplevel) || return
  cd "$root"
}

##########
# プラグインマネージャー
##########

# ZENO の初期化抑制 (sheldon の前に必要)
export ZENO_DISABLE_EXECUTE_CACHE_COMMAND=1

# zeno をソケットモードで起動
export ZENO_ENABLE_SOCK=1

# sheldon
eval "$(sheldon source)"

##########
# zeno.zsh
##########

export ZENO_HOME="$HOME/.config/zeno"
export ZENO_GIT_CAT="bat --color=always"

if [[ -n $ZENO_LOADED ]]; then
  bindkey ' ' zeno-auto-snippet
  bindkey '^m' zeno-auto-snippet-and-accept-line
  bindkey '^i' zeno-completion
  bindkey '^xx' zeno-insert-snippet

  bindkey '^x ' zeno-insert-space
  bindkey '^x^m' accept-line
  bindkey '^x^z' zeno-toggle-auto-snippet

  # preprompt bindings
  bindkey '^xp' zeno-preprompt
  bindkey '^xs' zeno-preprompt-snippet

  # zeno に候補がなければ fzf-tab を使う
  export ZENO_COMPLETION_FALLBACK=fzf-tab-complete
fi

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
