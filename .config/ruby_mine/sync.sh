#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

ln -fnsv "${SCRIPT_DIR}/.ideavimrc" "${HOME}/.ideavimrc"

