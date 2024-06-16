#!/bin/zsh

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo $SCRIPT_DIR

ln -fnsv "${SCRIPT_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
