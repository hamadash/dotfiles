# dotfiles

## Install

新しい Mac 端末で一括設定する場合のコマンド。

※ ホームディレクトリで実行。

```sh
git clone https://github.com/hamadash/dotfiles.git
```

```sh
cd dotfiles && make
```

## Manually Setup

手動でセットアップが必要なもの。

### Browser

chrome/extensions, brave/extensions に記載された URL にアクセスし、直接追加する。

ブラウザごとに、以下のコマンドで現在使っている端末の拡張機能をエクスポートできるので、移行前に旧端末で実行しておく。

#### Google Chrome

```sh
ls -l ${HOME}/Library/Application\ Support/Google/Chrome/Default/Extensions | awk '{print $9}' | sed 's/^/https:\/\/chrome.google.com\/webstore\/detail\//g' | sed -e '1,2d' > ~/dotfiles/chrome/extensions
```

#### Brave

```sh
ls -l ${HOME}/Library/Application\ Support/BraveSoftware/Brave-Browser/Default/Extensions | awk '{print $9}' | sed 's/^/https:\/\/chrome.google.com\/webstore\/detail\//g' | sed -e '1,2d' > ~/dotfiles/brave/extensions
```

### Raycast

旧端末で `Export Settings & Data` で、 raycast フォルダに rayconfig ファイルをエクスポートする。
