# `eval "$(brew shellenv)"` の出力を静的に展開したもの。
# brew はインストール先が固定なら毎回同じものを出力するだけなので、
# シェル起動ごとの brew プロセス起動 (~30ms + コールド時はもっと) を省く。
# Homebrew を /opt/homebrew 以外に入れ直した場合は書き直すこと。
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"

fpath[1,0]="/opt/homebrew/share/zsh/site-functions"

# brew shellenv は path_helper を呼び直して PATH の先頭に homebrew を
# 差し込むが、やりたいことはこの 2 行と同じ (重複は typeset -U で除去)
path[1,0]=(/opt/homebrew/bin /opt/homebrew/sbin)
typeset -gU path fpath

export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
