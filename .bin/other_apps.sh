#!/bin/zsh

# brewやApp Storeでインストールできないアプリケーション

function ask_yes_no {
  while true; do
    echo -n "$* [Y/n]: (default: y) "
    read ANS
    case $ANS in
      [Yy]* | "")
        return 0
        ;;
      [Nn]*)
        return 1
        ;;
    esac
  done
}

function app_dl_web {
  if ask_yes_no "Do you want to download $1?"; then
    sleep 1; echo "Download $1"
    sleep 1; open $2
  fi
}

function app_dl_curl {
  DL_PATH="$HOME/Downloads/$(basename $2)"
  if ask_yes_no "Do you want to download $1?"; then
    sleep 1; echo "Download $1"
    sleep 1; curl $2 --output $DL_PATH
    open $DL_PATH
  fi
}

app_dl_curl "Clipy" https://github.com/Clipy/Clipy/releases/download/1.2.1/Clipy_1.2.1.dmg
app_dl_curl "Logi Options+" https://download01.logi.com/web/ftp/pub/techsupport/optionsplus/logioptionsplus_installer.zip
app_dl_curl "Obsidian" https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.8/Obsidian-1.5.8-universal.dmg
app_dl_curl "Rectangle" https://github.com/rxhanson/Rectangle/releases/download/v0.76/Rectangle0.76.dmg

# TODO
# google日本語入力 https://www.google.co.jp/ime/
