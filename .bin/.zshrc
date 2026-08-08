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

# zsh のバージョンを刻んだスタンプ。zcompile したファイルが古いかの判定に使う。
#
# zsh を上げると .zwc はバージョン不一致で黙って無視される。ソースに
# フォールバックするので壊れはしないが、高速化だけが静かに失われる。
# このときソース側の mtime は変わらないので、ソースとの比較では検知できない。
# バージョンが変わるとこのファイルが作り直されて mtime が進むため、
# 「スタンプより古い .zwc は作り直す」だけで追従できる。
_ZWC_STAMP="$HOME/.zsh/cache/.zsh-$ZSH_VERSION"

if [[ ! -e $_ZWC_STAMP ]]; then
  mkdir -p "${_ZWC_STAMP:h}" 2>/dev/null
  rm -f "$HOME"/.zsh/cache/.zsh-*(N)
  : > "$_ZWC_STAMP" 2>/dev/null
fi

# <file>.zwc が無い / ソースより古い / zsh のバージョンが変わった場合に作り直す
zcompile_if_stale() {
  [[ -s "$1" ]] || return
  [[ -s "$1.zwc" && ! "$1" -nt "$1.zwc" && ! "$_ZWC_STAMP" -nt "$1.zwc" ]] && return

  zcompile -R -- "$1" 2>/dev/null
}

# eval "$(cmd ...)" の出力をファイルにキャッシュして source する。
#
# キャッシュはコマンド本体 (と CACHED_EVAL_DEPS で渡した設定ファイル) より
# 古くなったときだけ作り直す。ツールを更新すればバイナリの mtime が進むので、
# 手動でキャッシュを消さなくても追従する。
# 生成時に zcompile しておくと、zsh は同名の .zwc が新しい場合そちらを読むため、
# 2 回目以降は毎回のパースを省ける。
#
# 例: CACHED_EVAL_DEPS=(~/.config/foo.toml) cached_eval foo init zsh
cached_eval() {
  local cache="$HOME/.zsh/cache/${1//\//_}.zsh"
  local dep
  local -i stale=0

  [[ -s "$cache" ]] || stale=1

  for dep in "${commands[$1]}" "${CACHED_EVAL_DEPS[@]}"; do
    [[ -n "$dep" && "$dep" -nt "$cache" ]] && stale=1
  done

  if (( stale )); then
    local output
    output="$("$@")" || return

    mkdir -p "${cache:h}" 2>/dev/null

    # キャッシュに書けない環境 (読み取り専用の HOME など) でも初期化は通す
    if ! print -r -- "$output" > "$cache" 2>/dev/null; then
      eval "$output"
      return
    fi
  fi

  # 既存キャッシュの移行分もここで拾えるよう、source の直前で判定する
  zcompile_if_stale "$cache"

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

CACHED_EVAL_DEPS=("$HOME/.config/mise/config.toml") cached_eval mise activate zsh

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

# 匿名関数で包んでいるのは、グロブ修飾子 (#q...) に extended_glob が必要で、
# かつ emulate -L のオプション退避を関数スコープに閉じ込めたいため。
() {
  emulate -L zsh -o extended_glob

  local dump="${ZDOTDIR:-$HOME}/.zcompdump"
  # 1 日以内に更新されたダンプがあれば、compaudit と dump 再生成を -C で省く
  local -a fresh=("$dump"(N.m-1))

  autoload -Uz compinit

  if (( $#fresh )); then
    compinit -C -d "$dump"
  else
    compinit -d "$dump"
  fi

  # 50KB 超のダンプをバイトコンパイルしておく (compinit は .zwc を自動で読む)
  zcompile_if_stale "$dump"
}

zstyle ':completion:*:*:git:*' script "$HOME/dotfiles/.zsh/git-completion.bash"

# GitHub CLI 補完
cached_eval gh completion -s zsh

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
CACHED_EVAL_DEPS=("$HOME/.config/sheldon/plugins.toml") cached_eval sheldon source

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

##########
# バイトコンパイル
##########

# 起動のたびに読む静的なスクリプトを zcompile しておく。
# zsh は <file>.zwc の方が新しければ自動でそちらを読むため、次回以降パースを省ける。
# 生成は「編集した直後の 1 回」だけ走り、その回は今読み終えたソースが対象になる。
#
# sheldon のプラグイン本体もここで拾う (未コンパイルだと計 146KB を毎回パースする)。
# 深さを固定しているのは、再帰グロブ ** がこのツリーで 3.5ms かかり、
# 節約できる時間を食ってしまうため。深さ固定なら 0.2ms で済む。
# fast-highlight / fast-string-highlight は拡張子がないので個別に拾う。
_zsh_repos="$HOME/.local/share/sheldon/repos/github.com"

for _zsh_src in \
  "$HOME/.zshrc" \
  "$HOME/dotfiles/.zsh/git-prompt.sh" \
  $_zsh_repos/*/*/*.zsh(N) \
  $_zsh_repos/*/*/lib/**/*.zsh(N) \
  $_zsh_repos/*/*/fast-*highlight(N.)
do
  zcompile_if_stale "$_zsh_src"
done

unset _zsh_src _zsh_repos
