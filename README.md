# dotfiles

dotfiles としつつも、いろんな設定ファイルを含んでいる。

## Install

新しい Mac 端末で一括設定する場合のコマンド。

※ ホームディレクトリで実行。

```sh
git clone https://github.com/hamadash/dotfiles.git
```

`.bin/.Brewfile` の mas のコメントアウトを外す

```sh
cd dotfiles && make
```

## Manual Setup

手動でセットアップが必要なもの。

### Browser

以下の各ブラウザのディレクトリにある extensions に記載された URL にアクセスし、直接追加する。

ブラウザごとに、以下のコマンドで現在使っている端末の拡張機能をエクスポートできるので、移行前に旧端末で実行しておく。

#### Google Chrome

```sh
ls -l ${HOME}/Library/Application\ Support/Google/Chrome/Default/Extensions | awk '{print $9}' | sed 's/^/https:\/\/chrome.google.com\/webstore\/detail\//g' | sed -e '1,2d' > ~/dotfiles/chrome/extensions
```

#### Brave

```sh
ls -l ${HOME}/Library/Application\ Support/BraveSoftware/Brave-Browser/Default/Extensions | awk '{print $9}' | sed 's/^/https:\/\/chrome.google.com\/webstore\/detail\//g' | sed -e '1,2d' > ~/dotfiles/brave/extensions
```

### Karabiner-Elements

旧端末で以下のコマンドを実行し、 karabiner_elements ディレクトリに各種設定ファイルをエクスポートする。

```sh
cp ~/.config/karabiner/karabiner.json ~/dotfiles/karabiner_elements/karabiner.json
```

```sh
cp ~/.config/karabiner/assets/complex_modifications/*.json ~/dotfiles/karabiner_elements/assets/complex_modifications/
```

その後、以下のコマンドを実行し、新端末に設定を反映する。

```sh
sh karabiner_elements/sync.sh
```

### Raycast

旧端末で `Export Settings & Data` から rayconfig ファイルをエクスポートする。

その後、新端末で rayconfig ファイルを手動でインポートする。

### VSCode

旧端末で以下を実行し、出力結果を `.vscode/extensions` に貼り付けておく。

```sh
code --list-extensions | pbcopy
```

### Cursor

旧端末で以下を実行し、出力結果を `.cursor/extensions` に貼り付けておく。

```sh
cursor --list-extensions | pbcopy
```

### dotfile とは関係ないが新端末でやっておくとよいこと

- Guest 用のログインアカウントを作成する
