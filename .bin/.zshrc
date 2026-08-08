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

##########
# 高速化の方針
#
# 1. プロンプト表示までの同期パスでは外部プロセスを一切起動しない。
#    eval "$(cmd init)" 系は cached_eval でファイルキャッシュ、
#    mise / brew はそもそも呼ばず PATH を静的に組む。
# 2. プラグイン・補完スクリプトは zsh-defer で最初のプロンプト表示後に読む。
# 3. 毎回読むスクリプトは zcompile 済みの .zwc から読む。
##########

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

path=(
  "$HOME/.local/bin"
  "$HOME/dotfiles/custom_commands"
  "/opt/homebrew/opt/libpq/bin"
  "/opt/homebrew/opt/mysql@8.0/bin"
  $path
)

# mise: `mise activate zsh` はプロンプトごとに hook-env (実測 ~100ms) を
# 起動するのでやめて、インストール済みツールの bin を直接 PATH に入れる。
# グローバルの [tools] しか使っておらず (プロジェクト別の .mise.toml /
# .tool-versions が無い) hook-env の結果はディレクトリに依らないため、
# 静的な PATH で等価になる。ツールの追加・更新には glob で自動追従する。
# プロジェクト別のバージョン切り替えを使い始めたら `mise activate zsh` に
# 戻すか shims (実行ごと +50ms) を検討すること。
() {
  local tool
  for tool in "$HOME/.local/share/mise/installs"/*/latest(N/); do
    if [[ -d "$tool/bin" ]]; then
      path[1,0]=("$tool/bin")
    else
      path[1,0]=("$tool")
    fi
  done
}

typeset -gU path

# tmux
export TMUX_TMPDIR=/tmp

##########
# エイリアス
##########

# bat
alias cat='bat'

# eza
alias ls='eza --icons auto -F always --hyperlink -h'

##########
# 補完 (compinit)
##########

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

##########
# プロンプト設定
##########

# starship (プロンプト描画に必要なので同期で読む。init 結果はキャッシュ済み)
cached_eval starship init zsh

# カレントディレクトリをタブに表示する
set_terminal_title() {
  print -Pn "\e]0;%~\a"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set_terminal_title

##########
# プラグインマネージャー (sheldon + zsh-defer)
#
# zsh-defer 本体だけが同期で読まれ、残りのプラグイン
# (fzf-tab / zeno / fast-syntax-highlighting / zsh-autosuggestions) は
# 最初のプロンプト表示後に plugins.toml の記述順で遅延ロードされる。
##########

# ZENO の初期化抑制 (sheldon の前に必要)
export ZENO_DISABLE_EXECUTE_CACHE_COMMAND=1

# zeno をソケットモードで起動
export ZENO_ENABLE_SOCK=1

export ZENO_HOME="$HOME/.config/zeno"
export ZENO_GIT_CAT="bat --color=always"

# zsh-autosuggestions: プロンプトごとの bindkey 再走査を省く
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# sheldon
CACHED_EVAL_DEPS=("$HOME/.config/sheldon/plugins.toml") cached_eval sheldon source

# zsh-defer が読めなかった場合 (オフラインでの初回 clone 失敗など) は
# 同期実行にフォールバックして、起動だけは通るようにする
if ! (( $+functions[zsh-defer] )); then
  zsh-defer() { "$@"; }
fi

##########
# 遅延初期化
#
# ここから下の zsh-defer はすべて「最初のプロンプト表示後」に、
# 積んだ順 (sheldon のプラグイン群 → ここ) で実行される。
##########

# zeno のキーバインド (zeno 本体の遅延ロード完了後に実行される)
_setup_zeno_bindings() {
  [[ -n $ZENO_LOADED ]] || return 0

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

  # zeno サーバー (Deno) をここで先に立ち上げておく。
  # サーバーはシェル PID ごとで、放っておくと初回の補完キーを押した
  # タイミングで Deno の起動を待たされる (体感の「補完が遅い」の正体)。
  if [[ ! -S $ZENO_SOCK ]] && (( $+functions[zeno-start-server] )); then
    zeno-start-server
  fi
}
zsh-defer _setup_zeno_bindings

# fzf
_setup_fzf_and_tools() {
  [[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

  # zoxide
  cached_eval zoxide init zsh

  # GitHub CLI 補完
  cached_eval gh completion -s zsh

  # git-prompt (starship を使わない場合のフォールバック用)
  source "$HOME/dotfiles/.zsh/git-prompt.sh"

  # peco の履歴検索 (~/.fzf.zsh が ^R を取るので、その後に上書きする)
  zle -N peco-history-selection
  bindkey '^R' peco-history-selection
}
zsh-defer _setup_fzf_and_tools

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

##########
# peco
##########

peco-history-selection() {
  BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | peco)
  CURSOR=$#BUFFER
  zle reset-prompt
}

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
_compile_static_scripts() {
  local src
  local repos="$HOME/.local/share/sheldon/repos/github.com"

  for src in \
    "$HOME/.zshrc" \
    "$HOME/dotfiles/.zsh/git-prompt.sh" \
    $repos/*/*/*.zsh(N) \
    $repos/*/*/lib/**/*.zsh(N) \
    $repos/*/*/fast-*highlight(N.)
  do
    zcompile_if_stale "$src"
  done
}
zsh-defer _compile_static_scripts
